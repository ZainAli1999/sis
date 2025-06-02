import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/client/model/client_model.dart';

part 'client_repository.g.dart';

@riverpod
ClientRepository clientRepository(Ref ref) {
  return ClientRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

class ClientRepository {
  final FirebaseFirestore _firestore;
  ClientRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _client =>
      _firestore.collection(FirebaseConstants.clientCollection);

  FutureEither<ClientModel> getClientById({
    required String id,
  }) async {
    try {
      final client = await _client.doc(id).get().then(
            (value) =>
                ClientModel.fromMap(value.data() as Map<String, dynamic>),
          );
      return Right(client);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
