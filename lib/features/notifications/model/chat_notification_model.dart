import 'package:cloud_firestore/cloud_firestore.dart';

class ChatNotificationModel {
  final Timestamp createdAt;
  final String id;
  final String uid;
  final String messageId;
  final int status;
  final String title;
  final String body;
  final bool isSeen;
  ChatNotificationModel({
    required this.createdAt,
    required this.id,
    required this.uid,
    required this.messageId,
    required this.status,
    required this.title,
    required this.body,
    required this.isSeen,
  });

  ChatNotificationModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? uid,
    String? messageId,
    int? status,
    String? title,
    String? body,
    bool? isSeen,
  }) {
    return ChatNotificationModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      messageId: messageId ?? this.messageId,
      status: status ?? this.status,
      title: title ?? this.title,
      body: body ?? this.body,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'id': id,
      'uid': uid,
      'messageId': messageId,
      'status': status,
      'title': title,
      'body': body,
      'isSeen': isSeen,
    };
  }

  factory ChatNotificationModel.fromMap(Map<String, dynamic> map) {
    return ChatNotificationModel(
      createdAt: map['createdAt'] ?? "",
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      messageId: map['messageId'] ?? '',
      status: map['status']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
