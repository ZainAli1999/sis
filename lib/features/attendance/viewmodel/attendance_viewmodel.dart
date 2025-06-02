import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/utils/ip_service.dart';
import 'package:sis/features/attendance/action/attendance_action.dart';
import 'package:sis/features/attendance/model/attendance_model.dart';
import 'package:sis/features/attendance/repository/attendance_repository.dart';

part 'attendance_viewmodel.g.dart';

@riverpod
Stream<int?> getAttendanceStatusByUid(Ref ref) {
  final user = ref.watch(currentUserNotifierProvider)!;

  final attendanceRepository = ref.watch(attendanceRepositoryProvider);

  return attendanceRepository
      .getAttendanceStatusByUid(uid: user.uid)
      .map((res) {
    switch (res) {
      case Left(value: final failure):
        throw failure.message;

      case Right(value: final status):
        return status;
    }
  });
}

@riverpod
Stream<List<AttendanceModel>> fetchAttendance(Ref ref) {
  final user = ref.watch(currentUserNotifierProvider)!;
  return ref
      .watch(attendanceRepositoryProvider)
      .fetchAttendance(user.uid)
      .map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Future<String?> getAttendanceIdByUid(Ref ref) async {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  final res = await ref
      .watch(attendanceRepositoryProvider)
      .getAttendanceIdByUid(uid: uid);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class AttendanceViewModel extends _$AttendanceViewModel {
  late AttendanceRepository _attendanceRepository;

  @override
  AsyncValue? build() {
    _attendanceRepository = ref.watch(attendanceRepositoryProvider);
    return null;
  }

  Future<void> checkIn({
    String? lateReason,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final today = DateTime.now();

    final DateTime currentDate = DateTime(today.year, today.month, today.day);

    final currentTime = TimeOfDay.now();

    final isAllowed = await IPCheckService.isAllowed();
    if (!isAllowed) {
      state = const AsyncValue.data(
        AttendanceAction.invalidIP(),
      );
      return;
    }

    final res = await _attendanceRepository.hasCheckedInToday(
      uid: user.uid,
      currentDate: currentDate,
    );

    switch (res) {
      case Left(value: final failure):
        state = AsyncValue.error(
          failure.message,
          StackTrace.current,
        );
        return;

      case Right(value: final hasCheckedIn):
        if (hasCheckedIn) {
          state = const AsyncValue.data(
            AttendanceAction.alreadyCheckedIn(),
          );
          return;
        }
    }
    final graceTime = user.graceTime;
    final nowInMinutes = currentTime.hour * 60 + currentTime.minute;
    final graceTimeInMinutes = graceTime.hour * 60 + graceTime.minute;
    final isLate = nowInMinutes > graceTimeInMinutes;

    if (isLate && (lateReason == null || lateReason.isEmpty)) {
      state = const AsyncValue.data(
        AttendanceAction.lateCheckInRequired(),
      );
      return;
    }

    final checkInResult = await _attendanceRepository.checkIn(
      uid: user.uid,
      date: currentDate,
      checkInTime: currentTime,
      lateReason: lateReason,
    );

    switch (checkInResult) {
      case Left(value: final failure):
        state = state = AsyncValue.error(
          failure.message,
          StackTrace.current,
        );
        break;

      case Right(value: final attendance):
        state = AsyncValue.data(
          AttendanceAction.checkedIn(attendance),
        );
        break;
    }
  }

  Future<void> checkOut({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final isAllowed = await IPCheckService.isAllowed();
    if (!isAllowed) {
      state = const AsyncValue.data(
        AttendanceAction.invalidIP(),
      );
      return;
    }

    final res = await _attendanceRepository.checkOut(
      id: id,
      uid: user.uid,
      checkOutTime: TimeOfDay.now(),
    );
    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = AsyncValue.data(
          AttendanceAction.checkedOut(r),
        );
        break;
    }
  }

  Future<void> markAbsent({
    required DateTime date,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _attendanceRepository.markAbsent(
      uid: user.uid,
      date: date,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;
      case Right():
        state = const AsyncValue.data(
          AttendanceAction.markedAbsent(),
        );
    }
  }
}
