import 'package:flutter/material.dart';

class AttendanceModel {
  final String id;
  final String uid;
  final int status;
  final TimeOfDay checkInTime;
  final TimeOfDay? checkOutTime;
  final DateTime date;
  final String? lateReason;

  AttendanceModel({
    required this.id,
    required this.uid,
    required this.status,
    required this.checkInTime,
    this.checkOutTime,
    required this.date,
    this.lateReason,
  });

  AttendanceModel copyWith({
    String? id,
    String? uid,
    int? status,
    TimeOfDay? checkInTime,
    TimeOfDay? checkOutTime,
    DateTime? date,
    String? lateReason,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      status: status ?? this.status,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      date: date ?? this.date,
      lateReason: lateReason ?? this.lateReason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'status': status,
      'checkInTime': checkInTime.hour * 60 + checkInTime.minute,
      'checkOutTime': checkOutTime != null
          ? checkOutTime!.hour * 60 + checkOutTime!.minute
          : null,
      'date': date.millisecondsSinceEpoch,
      'lateReason': lateReason,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] ?? "",
      uid: map['uid'] ?? "",
      status: map['status'] ?? 0,
      checkInTime: TimeOfDay(
        hour: (map['checkInTime'] ?? 0) ~/ 60,
        minute: (map['checkInTime'] ?? 0) % 60,
      ),
      checkOutTime: map['checkOutTime'] != null
          ? TimeOfDay(
              hour: (map['checkOutTime'] ?? 0) ~/ 60,
              minute: (map['checkOutTime'] ?? 0) % 60,
            )
          : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      lateReason: map['lateReason'] ?? "",
    );
  }
}
