import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/leave/model/leave_model.dart';
import 'package:uuid/uuid.dart';

part 'leave_repository.g.dart';

@riverpod
LeaveRepository leaveRepository(Ref ref) {
  return LeaveRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class LeaveRepository {
  final FirebaseFirestore _firestore;
  LeaveRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _leave =>
      _firestore.collection(FirebaseConstants.leaveCollection);

  FutureEither<LeaveModel> addLeave({
    required String uid,
    required DateTime startDate,
    required DateTime endDate,
    required String leaveType,
    required String reason,
  }) async {
    try {
      final id = const Uuid().v1();

      LeaveModel leave = LeaveModel(
        createdAt: Timestamp.now(),
        id: id,
        uid: uid,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        status: 0,
      );

      await _leave.doc(id).set(leave.toMap());

      return Right(leave);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<LeaveModel>> fetchLeaves(String uid) {
    try {
      return _leave.where('uid', isEqualTo: uid).snapshots().map((event) {
        List<LeaveModel> leaves = [];

        for (var document in event.docs) {
          var leave =
              LeaveModel.fromMap(document.data() as Map<String, dynamic>);
          leaves.add(leave);
        }
        return Right(leaves);
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
