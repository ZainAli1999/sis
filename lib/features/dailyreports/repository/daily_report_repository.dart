import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/dailyreports/model/daily_report_model.dart';
import 'package:uuid/uuid.dart';

part 'daily_report_repository.g.dart';

@riverpod
DailyReportRepository dailyReportRepository(Ref ref) {
  return DailyReportRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class DailyReportRepository {
  final FirebaseFirestore _firestore;
  DailyReportRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _dailyReports =>
      _firestore.collection(FirebaseConstants.dailyReportsCollection);

  FutureEither<DailyReportModel> addDailyReport({
    required String uid,
    required String taskName,
    required String projectName,
    required String? note,
    required String priority,
  }) async {
    try {
      final id = const Uuid().v1();

      DailyReportModel dailyReport = DailyReportModel(
        createdAt: Timestamp.now(),
        id: id,
        uid: uid,
        taskName: taskName,
        projectName: projectName,
        note: note ?? "",
        priority: priority,
      );
      await _dailyReports.doc(id).set(dailyReport.toMap());
      return Right(dailyReport);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<DailyReportModel>> fetchDailyReports(String uid) {
    try {
      return _dailyReports
          .where('uid', isEqualTo: uid)
          .snapshots()
          .map((event) {
        List<DailyReportModel> dailyReports = [];

        for (var document in event.docs) {
          var dailyReport =
              DailyReportModel.fromMap(document.data() as Map<String, dynamic>);
          dailyReports.add(dailyReport);
        }
        return Right(dailyReports);
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

  FutureEither<DailyReportModel> getDailyReportById({
    required String id,
  }) async {
    try {
      final dailyReport = await _dailyReports.doc(id).get().then(
            (value) =>
                DailyReportModel.fromMap(value.data() as Map<String, dynamic>),
          );
      return Right(dailyReport);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
