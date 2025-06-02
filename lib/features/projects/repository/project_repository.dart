import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/projects/models/project_model.dart';

part 'project_repository.g.dart';

@riverpod
ProjectRepository projectRepository(Ref ref) {
  return ProjectRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class ProjectRepository {
  final FirebaseFirestore _firestore;

  ProjectRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _projects =>
      _firestore.collection(FirebaseConstants.projectsCollection);

  StreamEither<List<ProjectModel>> fetchProjects(String uid) {
    try {
      return _projects
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((event) {
        List<ProjectModel> projects = [];
        for (var document in event.docs) {
          var project =
              ProjectModel.fromMap(document.data() as Map<String, dynamic>);
          if (project.assignedTo.contains(uid)) {
            projects.add(project);
          }
        }
        return Right(projects);
      });
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

  FutureEither<ProjectModel> getProjectById({
    required String id,
  }) async {
    try {
      final project = await _projects.doc(id).get().then(
            (value) =>
                ProjectModel.fromMap(value.data() as Map<String, dynamic>),
          );
      return Right(project);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
