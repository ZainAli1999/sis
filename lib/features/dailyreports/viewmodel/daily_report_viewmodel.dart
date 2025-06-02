import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/dailyreports/model/daily_report_model.dart';
import 'package:sis/features/dailyreports/repository/daily_report_repository.dart';

part 'daily_report_viewmodel.g.dart';

@riverpod
Stream<List<DailyReportModel>> dailyReports(Ref ref) {
  final user = ref.watch(currentUserNotifierProvider)!;
  return ref
      .watch(dailyReportRepositoryProvider)
      .fetchDailyReports(user.uid)
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
Future<DailyReportModel> dailyReportById(Ref ref, String id) async {
  final res =
      await ref.watch(dailyReportRepositoryProvider).getDailyReportById(id: id);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class DailyViewModel extends _$DailyViewModel {
  late DailyReportRepository _dailyReportRepository;

  @override
  AsyncValue? build() {
    _dailyReportRepository = ref.watch(dailyReportRepositoryProvider);
    return null;
  }

  Future<void> addDailyReport({
    required String taskName,
    required String projectName,
    required String note,
    required String priority,
  }) async {
    state = const AsyncValue.loading();

    final uid = ref.watch(currentUserNotifierProvider)!.uid;

    final res = await _dailyReportRepository.addDailyReport(
      uid: uid,
      taskName: taskName,
      projectName: projectName,
      note: note,
      priority: priority,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = AsyncValue.data(r);
        break;
    }
  }
}
