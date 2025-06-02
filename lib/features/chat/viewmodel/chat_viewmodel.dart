import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/features/chat/model/chat_contact_model.dart';
import 'package:sis/features/chat/model/group_model.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/chat/repository/chat_repository.dart';

part 'chat_viewmodel.g.dart';

@riverpod
Stream<GroupModel> groupById(Ref ref, String id) {
  return ref.watch(chatRepositoryProvider).getGroupById(id).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Stream<int> unseenMessagesCount(Ref ref, String senderId, String receiverId) {
  final currentUserId = ref.watch(currentUserNotifierProvider)!.uid;
  return ref
      .watch(chatRepositoryProvider)
      .getUnseenMessagesCount(
        senderId: senderId,
        receiverId: receiverId,
        currentUserId: currentUserId,
      )
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
Stream<List<GroupModel>> chatGroups(Ref ref) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref.watch(chatRepositoryProvider).getChatGroups(uid).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Stream<List<ChatContactModel>> chatContacts(Ref ref) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref.watch(chatRepositoryProvider).getChatContacts(uid).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Stream<List<MessageModel>> chatStream(Ref ref, String contactId) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref
      .watch(chatRepositoryProvider)
      .getChatStream(Helpers.chatId(contactId, uid))
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
Stream<List<MessageModel>> groupChatStream(Ref ref, String groupId) {
  return ref
      .watch(chatRepositoryProvider)
      .getGroupChatStream(groupId)
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
class ChatViewModel extends _$ChatViewModel {
  late ChatRepository _chatRepository;

  @override
  AsyncValue? build() {
    _chatRepository = ref.watch(chatRepositoryProvider);
    return null;
  }

  Future<void> sendTextMessage({
    required String receiverId,
    required String text,
    required bool isGroupChat,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _chatRepository.sendTextMessage(
      receiverId: receiverId,
      text: text,
      senderId: user.uid,
      isGroupChat: isGroupChat,
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

  Future<void> sendFileMessage({
    required String receiverId,
    required String text,
    File? file,
    Uint8List? webFile,
    required MessageEnum messageEnum,
    required bool isGroupChat,
    required List<String> deviceTokens,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _chatRepository.sendFileMessage(
      receiverId: receiverId,
      senderId: user.uid,
      text: text,
      file: file,
      webFile: webFile,
      messageEnum: messageEnum,
      isGroupChat: isGroupChat,
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

  Future<void> editMyMessage({
    required String receiverId,
    required String messageId,
    required String text,
    required bool isGroupChat,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _chatRepository.editMyMessage(
      senderId: user.uid,
      receiverId: receiverId,
      messageId: messageId,
      text: text,
      isGroupChat: isGroupChat,
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

  Future<void> deleteMyMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    state = const AsyncValue.loading();

    final res = await _chatRepository.deleteMyMessage(
      senderId: senderId,
      receiverId: receiverId,
      messageId: messageId,
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

  Future<void> createGroup({
    required String name,
    File? file,
    Uint8List? webFile,
    required List<String> selectedUser,
  }) async {
    state = const AsyncValue.loading();

    final uid = ref.read(currentUserNotifierProvider)!.uid;

    final res = await _chatRepository.createGroup(
      uid: uid,
      name: name,
      file: file,
      webFile: webFile,
      selectedUser: selectedUser,
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

  Future<void> addMembers({
    required String id,
    required List<String> addMemberUid,
  }) async {
    state = const AsyncValue.loading();

    final res = await _chatRepository.addMembers(
      id: id,
      addMemberUid: addMemberUid,
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

  Future<void> removeMember({
    required String id,
    required String memberIdToRemove,
  }) async {
    state = const AsyncValue.loading();

    final res = await _chatRepository.removeMember(
      id: id,
      memberIdToRemove: memberIdToRemove,
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

  Future<void> setChatMessageSeen(
    String senderId,
    String receiverId,
  ) async {
    state = const AsyncValue.loading();

    final currentUserId = ref.watch(currentUserNotifierProvider)!.uid;

    final res = await _chatRepository.setChatMessageSeen(
      senderId: senderId,
      receiverId: receiverId,
      currentUserId: currentUserId,
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
