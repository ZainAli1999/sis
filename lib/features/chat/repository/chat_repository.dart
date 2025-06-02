import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/enums/message_enum.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/helpers.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/core/utils/upload_image_web.dart';
import 'package:sis/features/chat/model/chat_contact_model.dart';
import 'package:sis/features/chat/model/group_model.dart';
import 'package:sis/features/chat/model/message_model.dart';
import 'package:sis/features/notifications/model/chat_notification_model.dart';
import 'package:sis/features/notifications/service/send_notification_service.dart';
import 'package:uuid/uuid.dart';

part 'chat_repository.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;
  CollectionReference get _chats =>
      _firestore.collection(FirebaseConstants.chatsCollection);
  CollectionReference get _groups =>
      _firestore.collection(FirebaseConstants.groupsCollection);
  CollectionReference get _notifications =>
      _firestore.collection(FirebaseConstants.chatNotificationCollection);

  void _saveDataToContactsSubcollection({
    required String receiverId,
    required String senderId,
    required String text,
    required bool isGroupChat,
  }) async {
    if (isGroupChat) {
      await _groups.doc(receiverId).update({
        'lastMessage': text,
        'timeSent': DateTime.now().millisecondsSinceEpoch,
      });
    } else {
      final timeSent = DateTime.now();

      final contactId = Helpers.chatId(receiverId, senderId);
      ChatContactModel contact = ChatContactModel(
        profilePic: "",
        contactId: contactId,
        senderId: senderId,
        receiverId: receiverId,
        timeSent: timeSent,
        lastMessage: text,
        uids: [receiverId, senderId],
      );

      await _chats.doc(contactId).set(contact.toMap());
    }
  }

  void _saveMessageToMessageSubcollection({
    required String receiverId,
    required String senderId,
    required MessageModel message,
    required bool isGroupChat,
  }) async {
    final messageId = message.messageId;

    if (isGroupChat) {
      await _groups
          .doc(receiverId)
          .collection('chats')
          .doc(messageId)
          .set(message.toMap());
    } else {
      final contactId = Helpers.chatId(receiverId, senderId);
      await _chats
          .doc(contactId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
    }
  }

  void _sendNotificationToUser({
    required String messageId,
    required String uid,
    required String text,
    required List<String> deviceTokens,
  }) async {
    final id = const Uuid().v1();

    ChatNotificationModel notification = ChatNotificationModel(
      createdAt: Timestamp.now(),
      id: id,
      uid: uid,
      messageId: messageId,
      status: 0,
      title: "New Message",
      body: text,
      isSeen: false,
    );

    await _notifications.doc(id).set(notification.toMap());

    await SendNotificationService.sendNotificationServiceApi(
      tokens: deviceTokens,
      title: "New Message",
      body: text,
      data: {
        "page": "notifications",
      },
    );
  }

  FutureEither<MessageModel> sendTextMessage({
    required String receiverId,
    required String senderId,
    required String text,
    required bool isGroupChat,
    required List<String> deviceTokens,
  }) async {
    try {
      final timeSent = DateTime.now();

      final messageId = const Uuid().v1();

      MessageModel message = MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        file: "",
        type: MessageEnum.text,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false,
        status: 1,
      );

      _saveDataToContactsSubcollection(
        receiverId: receiverId,
        senderId: senderId,
        text: text,
        isGroupChat: isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        receiverId: receiverId,
        senderId: senderId,
        message: message,
        isGroupChat: isGroupChat,
      );

      _sendNotificationToUser(
        messageId: messageId,
        uid: receiverId,
        text: text,
        deviceTokens: deviceTokens,
      );

      return Right(message);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<MessageModel> sendFileMessage({
    required String receiverId,
    required String? text,
    File? file,
    Uint8List? webFile,
    required String senderId,
    required MessageEnum messageEnum,
    required bool isGroupChat,
    required List<String> deviceTokens,
  }) async {
    try {
      final timeSent = DateTime.now();

      final messageId = const Uuid().v1();

      String? imageUrl;

      if (file != null || webFile != null) {
        try {
          if (kIsWeb) {
            imageUrl = await uploadImageWeb(
              webFile!,
              "webFile $messageId",
              "webFile $messageId",
            );
          } else {
            final cloudinary = CloudinaryPublic(
              CloudinaryConstants.cloudName,
              CloudinaryConstants.uploadPreset,
            );

            CloudinaryResponse res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                file!.path,
                folder: "file $messageId",
              ),
            );
            imageUrl = res.secureUrl;
          }
        } catch (e) {
          return Left(
            Failure(
              "Image upload failed: ${e.toString()}",
            ),
          );
        }
      }

      String contactMessage;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMessage = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMessage = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMessage = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMessage = 'GIF';
          break;
        default:
          contactMessage = 'GIF';
      }

      MessageModel message = MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        text: text ?? "",
        file: imageUrl!,
        type: MessageEnum.image,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false,
        status: 1,
      );

      _saveDataToContactsSubcollection(
        receiverId: receiverId,
        senderId: senderId,
        text: contactMessage,
        isGroupChat: isGroupChat,
      );

      _saveMessageToMessageSubcollection(
        receiverId: receiverId,
        senderId: senderId,
        message: message,
        isGroupChat: isGroupChat,
      );

      _sendNotificationToUser(
        messageId: messageId,
        uid: receiverId,
        text: contactMessage,
        deviceTokens: deviceTokens,
      );

      return Right(message);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<MessageModel> editMyMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
    required String text,
    required bool isGroupChat,
  }) async {
    try {
      final chatId = Helpers.chatId(senderId, receiverId);

      final messageRef =
          _chats.doc(chatId).collection('messages').doc(messageId);

      final messageDocSnapshot = await messageRef.get();

      if (!messageDocSnapshot.exists) {
        return Left(
          Failure(
            'Message not found',
          ),
        );
      }

      final existingMessageData = MessageModel.fromMap(
        messageDocSnapshot.data() as Map<String, dynamic>,
      );

      final updatedMessage = existingMessageData.copyWith(
        text: text,
        status: 2,
      );

      await messageRef.update(updatedMessage.toMap());

      return Right(updatedMessage);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<MessageModel> deleteMyMessage({
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    try {
      final chatId = Helpers.chatId(senderId, receiverId);

      final messageDocSnapshot =
          await _chats.doc(chatId).collection('messages').doc(messageId).get();

      if (!messageDocSnapshot.exists) {
        return Left(
          Failure(
            'Message not found',
          ),
        );
      }

      final existingMessageData = MessageModel.fromMap(
        messageDocSnapshot.data() as Map<String, dynamic>,
      );

      await _chats.doc(chatId).collection('messages').doc(messageId).delete();

      return Right(existingMessageData);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<GroupModel> createGroup({
    required String uid,
    required String name,
    File? file,
    Uint8List? webFile,
    required List<String> selectedUser,
  }) async {
    try {
      final groupId = const Uuid().v1();

      final uniqueSelectedUsers = selectedUser.toSet().toList();

      String? imageUrl;

      if (file != null || webFile != null) {
        try {
          if (kIsWeb) {
            imageUrl = await uploadImageWeb(
              webFile!,
              "webFile $groupId",
              "webFile $groupId",
            );
          } else {
            final cloudinary = CloudinaryPublic(
              CloudinaryConstants.cloudName,
              CloudinaryConstants.uploadPreset,
            );

            CloudinaryResponse res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                file!.path,
                folder: "file $groupId",
              ),
            );
            imageUrl = res.secureUrl;
          }
        } catch (e) {
          return Left(
            Failure(
              "Image upload failed: ${e.toString()}",
            ),
          );
        }
      }

      GroupModel group = GroupModel(
        createdAt: Timestamp.now(),
        senderId: uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: imageUrl!,
        membersUid: [uid, ...uniqueSelectedUsers],
        timeSent: DateTime.now(),
      );

      await _groups.doc(groupId).set(group.toMap());
      return Right(group);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<GroupModel> addMembers({
    required String id,
    required List<String> addMemberUid,
  }) async {
    try {
      final groupDoc = await _groups.doc(id).get();

      final existingGroupData =
          GroupModel.fromMap(groupDoc.data() as Map<String, dynamic>);

      final uniqueMemberUids = [
        ...existingGroupData.membersUid,
        ...addMemberUid.where(
          (memberUid) => !existingGroupData.membersUid.contains(memberUid),
        ),
      ];

      final updatedMembers = existingGroupData.copyWith(
        membersUid: uniqueMemberUids,
      );

      await _groups.doc(id).update(updatedMembers.toMap());

      return Right(updatedMembers);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<GroupModel> removeMember({
    required String id,
    required String memberIdToRemove,
  }) async {
    try {
      final groupDoc = await _groups.doc(id).get();
      final existingGroupData =
          GroupModel.fromMap(groupDoc.data() as Map<String, dynamic>);

      final uniqueMemberUids = List<String>.from(existingGroupData.membersUid)
        ..remove(memberIdToRemove);

      final updatedMembers = existingGroupData.copyWith(
        membersUid: uniqueMemberUids,
      );

      await _groups.doc(id).update(updatedMembers.toMap());

      return Right(updatedMembers);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<int> getUnseenMessagesCount({
    required String senderId,
    required String receiverId,
    required String currentUserId,
  }) {
    if (currentUserId != receiverId) {
      return Stream.value(const Right(0));
    }
    final chatId = Helpers.chatId(senderId, receiverId);
    try {
      return _chats
          .doc(chatId)
          .collection('messages')
          .where('isSeen', isEqualTo: false)
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .snapshots()
          .map((snapshot) {
        final count = snapshot.docs.length;
        log("Unseen messages from $senderId to $receiverId: $count");
        return Right(count);
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

  StreamEither<List<GroupModel>> getChatGroups(String uid) {
    try {
      return _groups.snapshots().map(
        (event) {
          List<GroupModel> groups = [];
          for (var document in event.docs) {
            var group =
                GroupModel.fromMap(document.data() as Map<String, dynamic>);

            if (group.membersUid.contains(uid)) {
              groups.add(group);
            }
          }
          return Right(groups);
        },
      );
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

  StreamEither<List<ChatContactModel>> getChatContacts(String uid) {
    try {
      return _chats
          .where('uids', arrayContainsAny: [uid])
          .orderBy('timeSent', descending: true)
          .snapshots()
          .map(
            (event) {
              List<ChatContactModel> contacts = [];

              for (var document in event.docs) {
                contacts.add(
                  ChatContactModel.fromMap(
                      document.data() as Map<String, dynamic>),
                );
              }
              return Right(contacts);
            },
          );
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

  StreamEither<List<MessageModel>> getChatStream(String contactId) {
    try {
      return _chats
          .doc(contactId)
          .collection('messages')
          .orderBy('timeSent')
          .snapshots()
          .map((event) {
        List<MessageModel> messages = [];
        for (var document in event.docs) {
          messages.add(
            MessageModel.fromMap(
              document.data(),
            ),
          );
        }
        return Right(messages);
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

  StreamEither<List<MessageModel>> getGroupChatStream(String groupId) {
    try {
      return _groups
          .doc(groupId)
          .collection('chats')
          .orderBy('timeSent')
          .snapshots()
          .map((event) {
        List<MessageModel> messages = [];
        for (var document in event.docs) {
          messages.add(
            MessageModel.fromMap(
              document.data(),
            ),
          );
        }
        return Right(messages);
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

  FutureEither setChatMessageSeen({
    required String senderId,
    required String receiverId,
    required String currentUserId,
  }) async {
    if (currentUserId != receiverId) {
      log("⛔ Current user is not the receiver. Skipping update.");
      return const Right(null);
    }
    try {
      final chatId = Helpers.chatId(senderId, receiverId);

      final querySnapshot = await _chats
          .doc(chatId)
          .collection('messages')
          .where('isSeen', isEqualTo: false)
          .where('senderId', isEqualTo: senderId)
          .where('receiverId', isEqualTo: receiverId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log("📭 No unseen messages found.");
        return const Right(null);
      }

      final batch = FirebaseFirestore.instance.batch();

      for (var doc in querySnapshot.docs) {
        log("✅ Marking message seen: ${doc.id}");
        batch.update(doc.reference, {'isSeen': true});
      }

      await batch.commit();

      return const Right(null);
    } catch (e) {
      log("❌ Error in setChatMessageSeen: $e");
      return Left(Failure(e.toString()));
    }
  }

  StreamEither<GroupModel> getGroupById(String id) {
    try {
      return _groups.doc(id).snapshots().map(
        (event) {
          return Right(
            GroupModel.fromMap(event.data() as Map<String, dynamic>),
          );
        },
      );
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
