import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/leave/model/leave_model.dart';
import 'package:sis/features/leave/repository/leave_repository.dart';
import 'package:sis/features/notifications/repository/notification_repository.dart';

part 'leave_viewmodel.g.dart';

@riverpod
Stream<List<LeaveModel>> fetchLeaves(Ref ref) {
  final user = ref.watch(currentUserNotifierProvider)!;
  return ref.watch(leaveRepositoryProvider).fetchLeaves(user.uid).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
class LeaveViewModel extends _$LeaveViewModel {
  late LeaveRepository _leaveRepository;
  late NotificationRepository _notificationRepository;

  @override
  AsyncValue? build() {
    _leaveRepository = ref.watch(leaveRepositoryProvider);
    _notificationRepository = ref.watch(notificationRepositoryProvider);
    return null;
  }

  Future<void> addLeave({
    required DateTime startDate,
    required DateTime endDate,
    required String leaveType,
    required String reason,
    required String title,
    required String body,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _leaveRepository.addLeave(
      uid: user.uid,
      startDate: startDate,
      endDate: endDate,
      leaveType: leaveType,
      reason: reason,
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

    final notificationRes = await _notificationRepository.sendNotification(
      title: title,
      body: body,
      uid: user.uid,
      receiverId: [],
      deviceTokens: deviceTokens,
    );

    switch (notificationRes) {
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
