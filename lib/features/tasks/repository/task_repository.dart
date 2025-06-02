import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/tasks/model/task_model.dart';
import 'package:uuid/uuid.dart';

part 'task_repository.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class TaskRepository {
  final FirebaseFirestore _firestore;
  TaskRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _tasks =>
      _firestore.collection(FirebaseConstants.tasksCollection);

  FutureEither<TaskModel> addTask({
    required String projectId,
    required String title,
    required String description,
    required DateTime deadline,
    required String priority,
    required List<String> assignedTo,
    required String createdBy,
    required List<String> deviceTokens,
  }) async {
    try {
      final id = const Uuid().v1();

      final uniqueAssignedTo = assignedTo.toSet().toList();

      TaskModel task = TaskModel(
        createdAt: Timestamp.now(),
        id: id,
        projectId: projectId,
        status: 0,
        title: title,
        description: description,
        deadline: deadline,
        priority: priority,
        assignedTo: uniqueAssignedTo,
        createdBy: createdBy,
      );
      await _tasks.doc(id).set(task.toMap());
      return Right(task);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<TaskModel> editTask({
    required String id,
    required String title,
    required String description,
    DateTime? deadline,
    required String priority,
    required List<String> assignedTo,
    required List<String> deviceTokens,
  }) async {
    try {
      final taskDoc = await _tasks.doc(id).get();
      final existingTaskDoc =
          TaskModel.fromMap(taskDoc.data() as Map<String, dynamic>);

      final uniqueAssignedTo = assignedTo.toSet().toList();

      final task = existingTaskDoc.copyWith(
        id: id,
        title: title,
        description: description,
        deadline: deadline,
        priority: priority,
        assignedTo: uniqueAssignedTo,
      );
      await _tasks.doc(id).update(task.toMap());
      return Right(task);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<TaskModel> doneTask({
    required String id,
  }) async {
    try {
      final tasksDoc = await _tasks.doc(id).get();

      final existingTasksDoc = TaskModel.fromMap(
        tasksDoc.data() as Map<String, dynamic>,
      );

      final task = existingTasksDoc.copyWith(
        status: 1,
      );

      await _tasks.doc(id).update(task.toMap());

      return Right(task);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<TaskModel>> fetchTasks({
    required String uid,
  }) {
    final controller = StreamController<Either<Failure, List<TaskModel>>>();

    final Map<String, TaskModel> taskMap = {};

    late final StreamSubscription createdBySub;
    late final StreamSubscription assignedToSub;

    void emitCombinedTasks() {
      final tasks = taskMap.values.toList();
      controller.add(Right(tasks));
    }

    try {
      createdBySub = _tasks
          .where('createdBy', isEqualTo: uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        for (final doc in snapshot.docs) {
          final task = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
          taskMap[doc.id] = task;
        }
        emitCombinedTasks();
      });

      assignedToSub = _tasks
          .where('assignedTo', arrayContains: uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        for (final doc in snapshot.docs) {
          final task = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
          taskMap[doc.id] = task;
        }
        emitCombinedTasks();
      });

      controller.onCancel = () async {
        await createdBySub.cancel();
        await assignedToSub.cancel();
      };

      return controller.stream;
    } catch (e) {
      return Stream.value(Left(Failure(e.toString())));
    }
  }

  StreamEither<List<TaskModel>> fetchTasksByStatus({
    required String uid,
    required int status,
  }) {
    final controller = StreamController<Either<Failure, List<TaskModel>>>();

    final Map<String, TaskModel> taskMap = {};

    late final StreamSubscription createdBySub;
    late final StreamSubscription assignedToSub;

    void emitCombinedTasks() {
      final tasks = taskMap.values.toList();
      controller.add(Right(tasks));
    }

    try {
      createdBySub = _tasks
          .where('createdBy', isEqualTo: uid)
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        for (final doc in snapshot.docs) {
          final task = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
          taskMap[doc.id] = task;
        }
        emitCombinedTasks();
      });

      assignedToSub = _tasks
          .where('assignedTo', arrayContains: uid)
          .where('status', isEqualTo: status)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        for (final doc in snapshot.docs) {
          final task = TaskModel.fromMap(doc.data() as Map<String, dynamic>);
          taskMap[doc.id] = task;
        }
        emitCombinedTasks();
      });

      controller.onCancel = () async {
        await createdBySub.cancel();
        await assignedToSub.cancel();
      };

      return controller.stream;
    } catch (e) {
      return Stream.value(
        Left(Failure(e.toString())),
      );
    }
  }

  FutureEither<TaskModel> getTaskById({
    required String id,
  }) async {
    try {
      final task = await _tasks.doc(id).get().then(
            (value) => TaskModel.fromMap(value.data() as Map<String, dynamic>),
          );
      return Right(task);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<List<TaskModel>> getTasksByProjectId({
    required String projectId,
  }) async {
    try {
      final tasksDoc =
          await _tasks.where('projectId', isEqualTo: projectId).get();

      final tasks = tasksDoc.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return Right(tasks);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
