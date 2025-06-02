import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/notifications/model/notification_model.dart';
import 'package:sis/features/notifications/repository/notification_repository.dart';

part 'notification_viewmodel.g.dart';

@riverpod
Stream<List<NotificationModel>> fetchMyNotifications(Ref ref) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref
      .watch(notificationRepositoryProvider)
      .fetchMyNotifications(uid)
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
class NotificationViewModel extends _$NotificationViewModel {
  late NotificationRepository _notificationRepository;
  @override
  AsyncValue? build() {
    _notificationRepository = ref.watch(notificationRepositoryProvider);
    return null;
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String uid,
    required List<String> receiverId,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final res = await _notificationRepository.sendNotification(
      title: title,
      body: body,
      uid: uid,
      receiverId: receiverId,
      deviceTokens: deviceTokens,
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
