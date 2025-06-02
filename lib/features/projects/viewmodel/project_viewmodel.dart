import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/projects/models/project_model.dart';
import 'package:sis/features/projects/repository/project_repository.dart';

part 'project_viewmodel.g.dart';

@riverpod
Stream<List<ProjectModel>> projects(Ref ref) {
  final uid = ref.watch(currentUserNotifierProvider)!.uid;
  return ref.watch(projectRepositoryProvider).fetchProjects(uid).map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Future<ProjectModel> projectById(Ref ref, String id) async {
  final res = await ref.watch(projectRepositoryProvider).getProjectById(id: id);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}
