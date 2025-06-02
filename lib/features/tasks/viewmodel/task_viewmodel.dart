import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/notifications/repository/notification_repository.dart';
import 'package:sis/features/tasks/model/task_model.dart';
import 'package:sis/features/tasks/repository/task_repository.dart';

part 'task_viewmodel.g.dart';

@riverpod
Stream<List<TaskModel>> fetchTasks(Ref ref) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref.watch(taskRepositoryProvider).fetchTasks(uid: uid).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Stream<List<TaskModel>> tasksByStatus(
  Ref ref,
  int status,
) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref
      .watch(taskRepositoryProvider)
      .fetchTasksByStatus(uid: uid, status: status)
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
Future<TaskModel> getTaskById(Ref ref, String id) async {
  final res = await ref.watch(taskRepositoryProvider).getTaskById(id: id);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<TaskModel>> getTasksByProjectId(Ref ref, String projectId) async {
  final res = await ref
      .watch(taskRepositoryProvider)
      .getTasksByProjectId(projectId: projectId);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class TaskViewModel extends _$TaskViewModel {
  late TaskRepository _taskRepository;
  late NotificationRepository _notificationRepository;

  @override
  AsyncValue? build() {
    _taskRepository = ref.watch(taskRepositoryProvider);
    _notificationRepository = ref.watch(notificationRepositoryProvider);
    return null;
  }

  Future<void> addTask({
    required String projectId,
    required List<String> receiverId,
    required String title,
    required String description,
    required DateTime deadline,
    required String priority,
    required List<String> assignedTo,
    required String body,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final uniqueDeviceTokens = deviceTokens.toSet().toList();

    final uniqueReceiverIds = receiverId.toSet().toList();

    final res = await _taskRepository.addTask(
      projectId: projectId,
      title: title,
      description: description,
      deadline: deadline,
      priority: priority,
      assignedTo: assignedTo,
      createdBy: user.uid,
      deviceTokens: uniqueDeviceTokens,
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
      receiverId: uniqueReceiverIds,
      deviceTokens: uniqueDeviceTokens,
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

  Future<void> editTask({
    required String id,
    required List<String> receiverId,
    required String title,
    required String description,
    DateTime? deadline,
    required String priority,
    required List<String> assignedTo,
    required String body,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final uniqueDeviceTokens = deviceTokens.toSet().toList();

    final uniqueReceiverIds = receiverId.toSet().toList();

    final res = await _taskRepository.editTask(
      id: id,
      title: title,
      description: description,
      deadline: deadline,
      priority: priority,
      assignedTo: assignedTo,
      deviceTokens: uniqueDeviceTokens,
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
      receiverId: uniqueReceiverIds,
      deviceTokens: uniqueDeviceTokens,
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

  Future<void> doneTask({
    required String id,
  }) async {
    state = const AsyncValue.loading();

    final res = await _taskRepository.doneTask(
      id: id,
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
