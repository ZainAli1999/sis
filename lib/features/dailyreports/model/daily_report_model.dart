import 'package:cloud_firestore/cloud_firestore.dart';

class DailyReportModel {
  final Timestamp createdAt;
  final String id;
  final String uid;
  final String taskName;
  final String projectName;
  final String note;
  final String priority;
  DailyReportModel({
    required this.createdAt,
    required this.id,
    required this.uid,
    required this.taskName,
    required this.projectName,
    required this.note,
    required this.priority,
  });

  DailyReportModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? uid,
    String? taskName,
    String? projectName,
    String? note,
    String? priority,
  }) {
    return DailyReportModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      taskName: taskName ?? this.taskName,
      projectName: projectName ?? this.projectName,
      note: note ?? this.note,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'uid': uid,
      'taskName': taskName,
      'projectName': projectName,
      'note': note,
      'priority': priority,
    };
  }

  factory DailyReportModel.fromMap(Map<String, dynamic> map) {
    return DailyReportModel(
      createdAt: map['createdAt'],
      id: map['id'] as String,
      uid: map['uid'] as String,
      taskName: map['taskName'] as String,
      projectName: map['projectName'] as String,
      note: map['note'] as String,
      priority: map['priority'] as String,
    );
  }
}
