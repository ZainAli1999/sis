import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final Timestamp createdAt;
  final String id;
  final int status;
  final String uid;
  final String title;
  final String description;
  final String organization;
  final DateTime startDate;
  final DateTime? dueDate;
  final String priority;
  final List<String> assignedTo;
  final bool isRecurring;
  final String? recurrenceFrequency;
  final int? recurrenceInterval;
  final List<String>? attachments;
  final DateTime? reminderTime;
  final Duration? timeEstimate;
  final DateTime deadline;
  ProjectModel({
    required this.createdAt,
    required this.id,
    required this.status,
    required this.uid,
    required this.title,
    required this.description,
    required this.organization,
    required this.startDate,
    this.dueDate,
    required this.priority,
    required this.assignedTo,
    required this.isRecurring,
    this.recurrenceFrequency,
    this.recurrenceInterval,
    this.attachments,
    this.reminderTime,
    this.timeEstimate,
    required this.deadline,
  });

  ProjectModel copyWith({
    Timestamp? createdAt,
    String? id,
    int? status,
    String? uid,
    String? title,
    String? description,
    String? organization,
    DateTime? dueDate,
    DateTime? startDate,
    String? priority,
    List<String>? assignedTo,
    bool? isRecurring,
    String? recurrenceFrequency,
    int? recurrenceInterval,
    List<String>? attachments,
    DateTime? reminderTime,
    Duration? timeEstimate,
    DateTime? deadline,
  }) {
    return ProjectModel(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      organization: organization ?? this.organization,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceFrequency: recurrenceFrequency ?? this.recurrenceFrequency,
      recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
      attachments: attachments ?? this.attachments,
      reminderTime: reminderTime ?? this.reminderTime,
      timeEstimate: timeEstimate ?? this.timeEstimate,
      deadline: deadline ?? this.deadline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'status': status,
      'uid': uid,
      'title': title,
      'description': description,
      'organization': organization,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'startDate': startDate.millisecondsSinceEpoch,
      'priority': priority,
      'assignedTo': assignedTo,
      'isRecurring': isRecurring,
      'recurrenceFrequency': recurrenceFrequency,
      'recurrenceInterval': recurrenceInterval,
      'attachments': attachments,
      'reminderTime': reminderTime?.millisecondsSinceEpoch,
      'timeEstimate': timeEstimate != null
          ? {
              'hours': timeEstimate!.inHours,
              'minutes': timeEstimate!.inMinutes % 60,
              'seconds': timeEstimate!.inSeconds % 60,
            }
          : null,
      'deadline': deadline.millisecondsSinceEpoch,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      createdAt: map['createdAt'] is Timestamp
          ? map['createdAt'] as Timestamp
          : Timestamp.fromMillisecondsSinceEpoch(0),
      id: map['id'] as String,
      status: map['status'] is int ? map['status'] as int : 0,
      uid: map['uid'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      organization: map['organization'] as String,
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
          : null,
      startDate: DateTime.fromMillisecondsSinceEpoch(
        map['startDate'] as int,
      ),
      priority: map['priority'] as String,
      assignedTo: List<String>.from(map['assignedTo'] as List),
      isRecurring: map['isRecurring'] as bool,
      recurrenceFrequency: map['recurrenceFrequency'] != null
          ? map['recurrenceFrequency'] as String
          : null,
      recurrenceInterval: map['recurrenceInterval'] != null
          ? map['recurrenceInterval'] as int
          : null,
      attachments: map['attachments'] != null
          ? List<String>.from(map['attachments'] as List)
          : null,
      reminderTime: map['reminderTime'] != null
          ? DateTime.tryParse(map['reminderTime'].toString())
          : null,
      timeEstimate: map['timeEstimate'] != null
          ? Duration(
              hours: map['timeEstimate']['hours'] ?? 0,
              minutes: map['timeEstimate']['minutes'] ?? 0,
              seconds: map['timeEstimate']['seconds'] ?? 0,
            )
          : null,
      deadline: DateTime.fromMillisecondsSinceEpoch(
        map['deadline'] as int,
      ),
    );
  }
}
