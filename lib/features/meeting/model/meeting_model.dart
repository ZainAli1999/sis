import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingModel {
  final Timestamp createdAt;
  final String id;
  final String uid;
  final DateTime date;
  final DateTime time;
  final int status;
  final String title;
  final String desc;
  final List<String> members;
  final String? goingReceipt;
  final String? returnReceipt;
  MeetingModel({
    required this.createdAt,
    required this.id,
    required this.uid,
    required this.date,
    required this.time,
    required this.status,
    required this.title,
    required this.desc,
    required this.members,
    this.goingReceipt,
    this.returnReceipt,
  });

  MeetingModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? uid,
    DateTime? date,
    DateTime? time,
    int? status,
    String? title,
    String? desc,
    List<String>? members,
    String? goingReceipt,
    String? returnReceipt,
  }) {
    return MeetingModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      members: members ?? this.members,
      goingReceipt: goingReceipt ?? this.goingReceipt,
      returnReceipt: returnReceipt ?? this.returnReceipt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'uid': uid,
      'date': date.millisecondsSinceEpoch,
      'time': time.millisecondsSinceEpoch,
      'status': status,
      'title': title,
      'desc': desc,
      'members': members,
      'goingReceipt': goingReceipt,
      'returnReceipt': returnReceipt,
    };
  }

  factory MeetingModel.fromMap(Map<String, dynamic> map) {
    return MeetingModel(
      createdAt: map['createdAt'] ?? '',
      id: map['id'] as String,
      uid: map['uid'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      status: map['status'] as int,
      title: map['title'] as String,
      desc: map['desc'] as String,
      members: List<String>.from(
        (map['members'] as List),
      ),
      goingReceipt:
          map['goingReceipt'] != null ? map['goingReceipt'] as String : null,
      returnReceipt:
          map['returnReceipt'] != null ? map['returnReceipt'] as String : null,
    );
  }
}
