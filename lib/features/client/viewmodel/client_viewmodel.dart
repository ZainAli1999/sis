import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/features/client/model/client_model.dart';
import 'package:sis/features/client/repository/client_repository.dart';

part 'client_viewmodel.g.dart';

@riverpod
Future<ClientModel> clientById(Ref ref, String id) async {
  final res = await ref.watch(clientRepositoryProvider).getClientById(id: id);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}
