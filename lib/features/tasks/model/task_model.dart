import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final Timestamp createdAt;
  final String id;
  final String projectId;
  final int status;
  final String title;
  final String description;
  final DateTime deadline;
  final String priority;
  final List<String> assignedTo;
  final String createdBy;
  TaskModel({
    required this.createdAt,
    required this.id,
    required this.projectId,
    required this.status,
    required this.title,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.assignedTo,
    required this.createdBy,
  });

  TaskModel copyWith({
    Timestamp? createdAt,
    String? id,
    String? projectId,
    int? status,
    String? title,
    String? description,
    DateTime? deadline,
    String? priority,
    List<String>? assignedTo,
    String? createdBy,
  }) {
    return TaskModel(
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        status: status ?? this.status,
        title: title ?? this.title,
        description: description ?? this.description,
        deadline: deadline ?? this.deadline,
        priority: priority ?? this.priority,
        assignedTo: assignedTo ?? this.assignedTo,
        createdBy: createdBy ?? this.createdBy);
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'id': id,
      'projectId': projectId,
      'status': status,
      'title': title,
      'description': description,
      'deadline': deadline.millisecondsSinceEpoch,
      'priority': priority,
      'assignedTo': assignedTo,
      'createdBy': createdBy,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      createdAt: map['createdAt'] ?? '',
      id: map['id'] ?? '',
      projectId: map['projectId'] ?? '',
      status: map['status']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline']),
      priority: map['priority'] ?? '',
      assignedTo: List<String>.from(map['assignedTo']),
      createdBy: map['createdBy'] ?? '',
    );
  }
}
