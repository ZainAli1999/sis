import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/providers/storage_repository.dart';
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/firebase_constants.dart';
import 'package:sis/core/utils/type_defs.dart';
import 'package:sis/features/auth/models/auth_model.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
    storageRepository: ref.watch(storageRepositoryProvider),
  );
}

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final StorageRepository _storageRepository;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required StorageRepository storageRepository,
  })  : _firestore = firestore,
        _auth = auth,
        _storageRepository = storageRepository;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<AuthModel> signInUser({
    required String email,
    required String password,
    required List<String> newDeviceToken,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;
      final userDocSnapshot = await _users.doc(uid).get();

      if (!userDocSnapshot.exists) {
        return Left(Failure("User data not found."));
      }

      final userData =
          AuthModel.fromMap(userDocSnapshot.data() as Map<String, dynamic>);

      if (userData.status != 1) {
        return Left(
          Failure("Your account has been deactivated. Please contact support."),
        );
      }

      final updatedTokens = {
        ...userData.deviceTokens,
        ...newDeviceToken,
      }.toList();

      await _users.doc(uid).update({
        'deviceTokens': updatedTokens,
      });

      final updatedUser = userData.copyWith(deviceTokens: updatedTokens);
      return Right(updatedUser);
    } on FirebaseAuthException catch (e) {
      final errorMessages = {
        "invalid-email": "Your email address appears to be malformed.",
        "user-not-found": "No user found with this email.",
        "wrong-password": "Your password is incorrect.",
        "invalid-credential": "Invalid credentials provided.",
        "user-disabled": "The user with this email has been disabled.",
        "email-already-in-use":
            "This email is already in use by another account.",
        "too-many-requests": "Too many requests. Please try again later.",
        "operation-not-allowed": "Email and Password sign-in is not enabled.",
      };
      return Left(
        Failure(
          errorMessages[e.code] ?? "An error occurred. Code: ${e.code}",
        ),
      );
    } catch (e, stackTrace) {
      log("Unknown error in signInUser: $e", stackTrace: stackTrace);
      return Left(
        Failure(
          "An unknown error occurred.",
        ),
      );
    }
  }

  FutureEither changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser!;

      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(cred);

      await user.updatePassword(newPassword);

      return Right(cred);
    } on FirebaseAuthException catch (e) {
      final errorMessages = {
        "wrong-password": "Your password is incorrect.",
        "user-not-found": "User not found",
        "too-many-requests": "Too many requests. Please try again later.",
      };
      return Left(
        Failure(
          errorMessages[e.code] ?? "An error occurred. Code: ${e.code}",
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither changeEmail({
    required String uid,
    required String currentPassword,
    required String newEmail,
  }) async {
    try {
      final user = _auth.currentUser!;

      final usersDoc = await _users.doc(uid).get();
      final existingUserData =
          AuthModel.fromMap(usersDoc.data() as Map<String, dynamic>);

      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(cred);

      await user.verifyBeforeUpdateEmail(newEmail);

      final userData = existingUserData.copyWith(
        email: newEmail,
      );

      await _users.doc(uid).update(userData.toMap());

      return Right(userData);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return Left(
          Failure(
            'Wrong Password',
          ),
        );
      } else if (e.code == 'user-not-found') {
        return Left(
          Failure(
            'User not found',
          ),
        );
      } else if (e.code == 'too-many-requests') {
        return Left(
          Failure('Too many requests'),
        );
      } else if (e.code == 'email-already-in-use') {
        return Left(
          Failure('Email is already in use'),
        );
      } else {
        return Left(
          Failure('An error occurred: An unknown error occurred.'),
        );
      }
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither forgotPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      final errorMessages = {
        "invalid-email": "Your email address appears to be corrupt.",
        "user-not-found": "No users with this email were found.",
        "user-disabled": "No users with this email were found.",
        "email-already-in-use":
            "This email is already used by another account.",
        "too-many-requests":
            "There are so many requests. Please try again later.",
        "operation-not-allowed":
            "Login with Email and Password is not enabled.",
      };
      return Left(
        Failure(
          errorMessages[e.code] ?? "An error occurred. Code: ${e.code}",
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<AuthModel> getCurrentUserData(String uid) async {
    try {
      final usersDoc = await _users.doc(uid).get();

      if (!usersDoc.exists) {
        return Left(Failure('User data not found'));
      }

      final user =
          AuthModel.fromMap(usersDoc.data() as Map<String, dynamic>).copyWith(
        uid: uid,
      );

      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  FutureEither logout() async {
    try {
      await _auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<AuthModel> editProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required File? profileImage,
  }) async {
    try {
      String? imageUrl;

      final usersDoc = await _users.doc(uid).get();
      final existingUserData =
          AuthModel.fromMap(usersDoc.data() as Map<String, dynamic>);

      if (profileImage != null) {
        final uploadResult = await _storageRepository.storeFile(
          file: profileImage,
          folder: "$firstName $lastName",
        );

        switch (uploadResult) {
          case Left(value: final failure):
            return Left(failure);
          case Right(value: final url):
            imageUrl = url;
            break;
        }
      } else {
        imageUrl = existingUserData.profileImage;
      }

      final user = existingUserData.copyWith(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        profileImage: imageUrl,
      );

      await _users.doc(uid).update(user.toMap());

      return Right(user);
    } catch (e) {
      return Left(
        Failure(e.toString()),
      );
    }
  }

  FutureEither updateDeviceToken({
    required List<String> newDeviceToken,
    required String uid,
  }) async {
    try {
      final usersDoc = await _users.doc(uid).get();

      if (!usersDoc.exists) {
        return Left(
          Failure(
            'User data not found',
          ),
        );
      }

      final existingUserData =
          AuthModel.fromMap(usersDoc.data() as Map<String, dynamic>);

      await _users.doc(uid).update({
        'deviceTokens': FieldValue.arrayUnion(newDeviceToken),
      });

      return Right(existingUserData);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  StreamEither<List<AuthModel>> fetchUsers() {
    try {
      return _users.snapshots().map((event) {
        final users = event.docs
            .map((e) => AuthModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        return Right(users);
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

  FutureEither<AuthModel> getUserById({
    required String uid,
  }) async {
    try {
      final doc = await _users.doc(uid).get();

      final data = doc.data();
      if (data == null) {
        return Left(Failure("User not found"));
      }

      final user = AuthModel.fromMap(data as Map<String, dynamic>);
      return Right(user);
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
