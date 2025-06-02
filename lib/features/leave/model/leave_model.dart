import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  final Timestamp createdAt;
  final String id;
  final String uid;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final int status;
  LeaveModel({
    required this.createdAt,
    required this.id,
    required this.uid,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
  });

  LeaveModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? uid,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    int? status,
  }) {
    return LeaveModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'uid': uid,
      'leaveType': leaveType,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'reason': reason,
      'status': status,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      createdAt: map['createdAt'] ?? '',
      id: map['id'] as String,
      uid: map['uid'] as String,
      leaveType: map['leaveType'] as String,
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
      reason: map['reason'] as String,
      status: map['status'] as int,
    );
  }
}
