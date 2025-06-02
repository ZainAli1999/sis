import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/notifications/model/notification_model.dart';
import 'package:sis/features/notifications/service/send_notification_service.dart';
import 'package:uuid/uuid.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class NotificationRepository {
  final FirebaseFirestore _firestore;
  NotificationRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _notifications =>
      _firestore.collection(FirebaseConstants.notificationCollection);

  FutureEither<NotificationModel> sendNotification({
    required String title,
    required String body,
    required String uid,
    required List<String> receiverId,
    required List<String> deviceTokens,
  }) async {
    final id = const Uuid().v1();

    try {
      NotificationModel notification = NotificationModel(
        createdAt: Timestamp.now(),
        id: id,
        receiverId: receiverId,
        uid: uid,
        status: 0,
        title: title,
        body: body,
        isSeen: false,
      );

      await _notifications.doc(id).set(notification.toMap());

      await SendNotificationService.sendNotificationServiceApi(
        tokens: deviceTokens,
        title: title,
        body: body,
        data: {
          "page": "Random",
        },
      );

      return Right(notification);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<NotificationModel>> fetchMyNotifications(String uid) {
    try {
      return _notifications
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map(
        (event) {
          List<NotificationModel> notifications = [];
          for (var document in event.docs) {
            var notification = NotificationModel.fromMap(
                document.data() as Map<String, dynamic>);

            if (notification.receiverId.contains(uid)) {
              notifications.add(notification);
            }
          }
          return Right(notifications);
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
