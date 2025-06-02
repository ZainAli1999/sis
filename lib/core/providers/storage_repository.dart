import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/type_defs.dart';

part 'storage_repository.g.dart';

@riverpod
StorageRepository storageRepository(Ref ref) {
  return StorageRepository(
    cloudinaryPublic: ref.watch(cloudinaryPublicProvider),
  );
}

class StorageRepository {
  final CloudinaryPublic _cloudinaryPublic;

  StorageRepository({
    required CloudinaryPublic cloudinaryPublic,
  }) : _cloudinaryPublic = cloudinaryPublic;

  FutureEither<String> storeFile({
    required File? file,
    required String folder,
  }) async {
    try {
      // Ensure the file is not null
      if (file == null) {
        return Left(Failure('No file provided'));
      }

      // Upload file to Cloudinary
      CloudinaryResponse res = await _cloudinaryPublic.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: folder, // Define folder for organized uploads
        ),
      );

      // Return the secure URL from the upload response
      return Right(res.secureUrl);
    } catch (e) {
      // Handle and return error as Failure
      return Left(Failure(e.toString()));
    }
  }
}
