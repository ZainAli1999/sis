import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/attendance/model/attendance_model.dart';
import 'package:uuid/uuid.dart';

part 'attendance_repository.g.dart';

@riverpod
AttendanceRepository attendanceRepository(Ref ref) {
  return AttendanceRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class AttendanceRepository {
  final FirebaseFirestore _firestore;
  AttendanceRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _attendance =>
      _firestore.collection(FirebaseConstants.attendanceCollection);

  FutureEither<AttendanceModel> checkIn({
    required String uid,
    required DateTime date,
    required TimeOfDay checkInTime,
    TimeOfDay? checkOutTime,
    String? lateReason,
  }) async {
    try {
      final id = const Uuid().v1();

      AttendanceModel attendance = AttendanceModel(
        id: id,
        uid: uid,
        status: 1,
        checkInTime: checkInTime,
        checkOutTime: checkOutTime,
        date: date,
        lateReason: lateReason,
      );

      await _attendance.doc(id).set(attendance.toMap());
      return Right(attendance);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither<bool> hasCheckedInToday({
    required String uid,
    required DateTime currentDate,
  }) async {
    try {
      final DateTime strippedDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);

      final attendanceDoc = await _attendance
          .where('uid', isEqualTo: uid)
          .where('date', isEqualTo: strippedDate.millisecondsSinceEpoch)
          .get();

      return Right(attendanceDoc.docs.isNotEmpty);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<AttendanceModel> checkOut({
    required String id,
    required String uid,
    required TimeOfDay checkOutTime,
  }) async {
    try {
      final attendanceDoc = await _attendance.doc(id).get();

      final existingAttendanceData =
          AttendanceModel.fromMap(attendanceDoc.data() as Map<String, dynamic>);

      final checkInTime = existingAttendanceData.checkInTime;

      int checkInMinutes = checkInTime.hour * 60 + checkInTime.minute;
      int checkOutMinutes = checkOutTime.hour * 60 + checkOutTime.minute;

      final differenceInMinutes = checkOutMinutes - checkInMinutes;

      if (differenceInMinutes > 720) {
        final closedAttendance = existingAttendanceData.copyWith(
          id: id,
          uid: uid,
          status: 3,
        );
        await _attendance.doc(id).update(closedAttendance.toMap());

        return Left(
          Failure('Check-out must be done within 12 hours of check-in.'),
        );
      } else {
        final attendance = existingAttendanceData.copyWith(
          id: id,
          uid: uid,
          status: 2,
          checkOutTime: checkOutTime,
        );
        await _attendance.doc(id).update(attendance.toMap());
        return Right(attendance);
      }
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<String?> getAttendanceIdByUid({
    required String uid,
  }) async {
    try {
      final querySnapshot = await _attendance
          .where('uid', isEqualTo: uid)
          .orderBy('date', descending: true)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return Right(querySnapshot.docs.first.id);
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(
        Failure(e.toString()),
      );
    }
  }

  StreamEither<int?> getAttendanceStatusByUid({
    required String uid,
  }) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _attendance
        .where('uid', isEqualTo: uid)
        .where('date',
            isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch)
        .where('date', isLessThan: endOfDay.millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return const Right(null);

      try {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        final status = data['status'] as int?;
        log("Status fetched from Firestore: $status");
        return Right(status);
      } catch (e, stackTrace) {
        log("Error fetching status: $e", stackTrace: stackTrace);
        return Left(Failure(e.toString()));
      }
    });
  }

  FutureEither<String> getTimeDifference({
    required DateTime checkInTime,
    required DateTime startTime,
  }) async {
    try {
      Duration difference = checkInTime.difference(startTime);
      if (difference.inMinutes.abs() <= 59) {
        return Right('${difference.inMinutes.abs()} minutes');
      } else {
        int hours = difference.inHours.abs();
        int minutes = (difference.inMinutes.abs() % 60);
        return Right('$hours hours and $minutes minutes');
      }
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<AttendanceModel> markAbsent({
    required String uid,
    required DateTime date,
  }) async {
    try {
      final id = const Uuid().v1();

      AttendanceModel attendance = AttendanceModel(
        id: id,
        uid: uid,
        status: 3,
        checkInTime: const TimeOfDay(hour: 0, minute: 0),
        checkOutTime: const TimeOfDay(hour: 0, minute: 0),
        date: date,
      );

      await _attendance.doc(id).set(attendance.toMap());
      return Right(attendance);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<AttendanceModel>> fetchAttendance(String uid) {
    try {
      return _attendance
          .orderBy('date', descending: true)
          .where('uid', isEqualTo: uid)
          .snapshots()
          .map((event) {
        final attendance = event.docs
            .map((e) =>
                AttendanceModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return Right(attendance);
      });
    } catch (e) {
      return Stream.value(
        Left(
          Failure(
            e.toString(),
          ),
        ),
      );
    }
  }
}
