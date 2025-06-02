import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/core/utils/upload_image_web.dart';
import 'package:sis/features/meeting/model/meeting_model.dart';
import 'package:uuid/uuid.dart';

part 'meeting_repository.g.dart';

@riverpod
MeetingRepository meetingRepository(Ref ref) {
  return MeetingRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class MeetingRepository {
  final FirebaseFirestore _firestore;
  MeetingRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _meeting =>
      _firestore.collection(FirebaseConstants.meetingCollection);

  // CollectionReference get _notifications =>
  //     _firestore.collection(FirebaseConstants.notificationsCollection);

  // void _sendNotificationToUser({
  //   required String uid,
  //   required String text,
  //   required List<String> deviceTokens,
  // }) async {
  //   final id = const Uuid().v1();

  //   NotificationModel notification = NotificationModel(
  //     createdAt: Timestamp.now(),
  //     id: id,
  //     uid: uid,
  //     status: 0,
  //     title: "New Notification",
  //     body: text,
  //     isSeen: false,
  //   );

  //   await _notifications.doc(id).set(notification.toMap());

  //   await SendNotificationService.sendNotificationServiceApi(
  //     tokens: deviceTokens,
  //     title: "New Message",
  //     body: text,
  //     data: {
  //       "page": "notifications",
  //     },
  //   );
  // }

  FutureEither<MeetingModel> addMeeting({
    required String uid,
    required TimeOfDay time,
    required DateTime date,
    required String title,
    required String desc,
    required List<String> members,
    required List<String> deviceTokens,
  }) async {
    try {
      final id = const Uuid().v1();

      final uniqueMembers = members.toSet().toList();

      final DateTime combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      MeetingModel meeting = MeetingModel(
        createdAt: Timestamp.now(),
        id: id,
        uid: uid,
        date: date,
        time: combinedDateTime,
        status: 0,
        title: title,
        desc: desc,
        members: uniqueMembers,
      );

      await _meeting.doc(id).set(meeting.toMap());

      return Right(meeting);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<MeetingModel>> fetchMeetings() {
    try {
      return _meeting.orderBy('createdAt', descending: true).snapshots().map(
        (event) {
          List<MeetingModel> meetings = [];
          for (var document in event.docs) {
            meetings.add(
                MeetingModel.fromMap(document.data() as Map<String, dynamic>));
          }
          return Right(meetings);
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

  FutureEither<MeetingModel> getMeetingById({
    required String id,
  }) async {
    try {
      final meeting = await _meeting.doc(id).get().then(
            (value) =>
                MeetingModel.fromMap(value.data() as Map<String, dynamic>),
          );
      return Right(meeting);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<MeetingModel> updateMeetingDetails({
    required String id,
    File? goingReceipt,
    File? returnReceipt,
    Uint8List? goingReceiptWeb,
    Uint8List? returnReceiptWeb,
  }) async {
    try {
      String? goingReceiptUrl;

      final meetingDoc = await _meeting.doc(id).get();

      final existingMeetingData =
          MeetingModel.fromMap(meetingDoc.data() as Map<String, dynamic>);

      if (goingReceipt != null || goingReceiptWeb != null) {
        try {
          if (kIsWeb) {
            goingReceiptUrl = await uploadImageWeb(
              goingReceiptWeb!,
              "goingReceipt $id",
              "goingReceipt $id",
            );
          } else {
            final cloudinary = CloudinaryPublic(
              CloudinaryConstants.cloudName,
              CloudinaryConstants.uploadPreset,
            );

            CloudinaryResponse res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                goingReceipt!.path,
                folder: "goingReceipt $id",
              ),
            );
            goingReceiptUrl = res.secureUrl;
          }
        } catch (e) {
          return Left(
            Failure(
              "Image upload failed: ${e.toString()}",
            ),
          );
        }
      } else {
        goingReceiptUrl = existingMeetingData.goingReceipt;
      }

      String? returnReceiptUrl;

      if (returnReceipt != null || returnReceiptWeb != null) {
        try {
          if (kIsWeb) {
            returnReceiptUrl = await uploadImageWeb(
              returnReceiptWeb!,
              "returnReceipt $id",
              "returnReceipt $id",
            );
          } else {
            final cloudinary = CloudinaryPublic(
              CloudinaryConstants.cloudName,
              CloudinaryConstants.uploadPreset,
            );

            CloudinaryResponse res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(
                returnReceipt!.path,
                folder: "returnReceipt $id",
              ),
            );
            returnReceiptUrl = res.secureUrl;
          }
        } catch (e) {
          return Left(
            Failure(
              "Image upload failed: ${e.toString()}",
            ),
          );
        }
      } else {
        returnReceiptUrl = existingMeetingData.returnReceipt;
      }

      final meeting = existingMeetingData.copyWith(
        goingReceipt: goingReceiptUrl,
        returnReceipt: returnReceiptUrl,
      );

      await _meeting.doc(id).update(meeting.toMap());

      return Right(meeting);
    } catch (e) {
      return Left(
        Failure(e.toString()),
      );
    }
  }
}
