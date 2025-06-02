import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/meeting/model/meeting_model.dart';
import 'package:sis/features/meeting/repository/meeting_repository.dart';
import 'package:sis/features/notifications/repository/notification_repository.dart';

part 'meeting_viewmodel.g.dart';

@riverpod
Stream<List<MeetingModel>> meetings(Ref ref) {
  return ref.watch(meetingRepositoryProvider).fetchMeetings().map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Future<MeetingModel> getMeetingById(Ref ref, String id) async {
  final res = await ref.watch(meetingRepositoryProvider).getMeetingById(id: id);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class MeetingViewModel extends _$MeetingViewModel {
  late MeetingRepository _meetingRepository;
  late NotificationRepository _notificationRepository;

  @override
  AsyncValue? build() {
    _meetingRepository = ref.watch(meetingRepositoryProvider);
    _notificationRepository = ref.watch(notificationRepositoryProvider);
    return null;
  }

  Future<void> addMeeting({
    required TimeOfDay time,
    required DateTime date,
    required String title,
    required String desc,
    required List<String> members,
    required String body,
    required List<String> receiverId,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _meetingRepository.addMeeting(
      uid: user.uid,
      time: time,
      date: date,
      title: title,
      desc: desc,
      members: members,
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

    final notificationRes = await _notificationRepository.sendNotification(
      title: title,
      body: body,
      uid: user.uid,
      receiverId: receiverId,
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

  Future<void> updateMeetingDetails({
    required String id,
    File? goingReceipt,
    File? returnReceipt,
    Uint8List? goingReceiptWeb,
    Uint8List? returnReceiptWeb,
  }) async {
    state = const AsyncValue.loading();

    final res = await _meetingRepository.updateMeetingDetails(
      id: id,
      goingReceipt: goingReceipt,
      returnReceipt: returnReceipt,
      goingReceiptWeb: goingReceiptWeb,
      returnReceiptWeb: returnReceiptWeb,
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
