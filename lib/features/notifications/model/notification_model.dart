import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final Timestamp createdAt;
  final String id;
  final String uid;
  final List<String> receiverId;
  final int status;
  final String title;
  final String body;
  final bool isSeen;
  NotificationModel({
    required this.createdAt,
    required this.id,
    required this.uid,
    required this.receiverId,
    required this.status,
    required this.title,
    required this.body,
    required this.isSeen,
  });

  NotificationModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? uid,
    List<String>? receiverId,
    int? status,
    String? title,
    String? body,
    bool? isSeen,
  }) {
    return NotificationModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      receiverId: receiverId ?? this.receiverId,
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
      'receiverId': receiverId,
      'status': status,
      'title': title,
      'body': body,
      'isSeen': isSeen,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      createdAt: map['createdAt'] ?? "",
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      receiverId: List<String>.from(map['receiverId']),
      status: map['status']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
