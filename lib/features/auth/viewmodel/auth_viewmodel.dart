import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/auth/models/auth_model.dart';
import 'package:sis/features/auth/repository/auth_local_repository.dart';
import 'package:sis/features/auth/repository/auth_repository.dart';
import 'package:sis/features/notifications/service/notification_service.dart';

part 'auth_viewmodel.g.dart';

@riverpod
Stream<List<AuthModel>> fetchUsers(Ref ref) {
  return ref.watch(authRepositoryProvider).fetchUsers().map((res) {
    switch (res) {
      case Left(value: final l):
        throw (l.message);
      case Right(value: final r):
        return r;
    }
  });
}

@riverpod
Future<AuthModel> getUserById(Ref ref, String uid) async {
  final res = await ref.watch(authRepositoryProvider).getUserById(uid: uid);
  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRepository _authRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue? build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  // Future<void> signUpUser({
  //   required String firstName,
  //   required String lastName,
  //   required String phoneNumber,
  //   required String cnic,
  //   required String designation,
  //   required String email,
  //   required String password,
  // }) async {
  //   state = const AsyncValue.loading();
  //   final res = await _authRepository.signUpUser(
  //     firstName: firstName,
  //     lastName: lastName,
  //     phoneNumber: phoneNumber,
  //     cnic: cnic,
  //     designation: designation,
  //     email: email,
  //     password: password,
  //   );

  //   switch (res) {
  //     case Left(value: final l):
  //       state = AsyncValue.error(
  //         l.message,
  //         StackTrace.current,
  //       );
  //       break;

  //     case Right(value: final r):
  //       state = _getDataSuccess(r);
  //       break;
  //   }
  // }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final deviceToken = await NotificationService().getDeviceToken();

    final res = await _authRepository.signInUser(
      email: email,
      password: password,
      newDeviceToken: [deviceToken],
    );
    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = _getDataSuccess(r);
        break;
    }
  }

  Future<void> sendVerificationEmail() async {
    state = const AsyncValue.loading();
    final res = await _authRepository.sendVerificationEmail();
    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
        break;

      case Right(value: final r):
        state = AsyncValue.data(r);
        break;
    }
  }

  Future<void> checkEmailVerification() async {
    state = const AsyncValue.loading();

    final res = await _authRepository.checkEmailVerification();

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
        break;

      case Right(value: final r):
        state = AsyncValue.data(r);
        break;
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = AsyncValue.data(r);
        break;
    }
  }

  Future<void> changeEmail({
    required String currentPassword,
    required String newEmail,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _authRepository.changeEmail(
      uid: user.uid,
      currentPassword: currentPassword,
      newEmail: newEmail,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = _getDataSuccess(r);
        break;
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRepository.forgotPassword(email: email);

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = AsyncValue.data(r);
        break;
    }
  }

  Future<void> editProfile({
    required String firstName,
    required String lastName,
    required File? profileImage,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.read(currentUserNotifierProvider)!;

    final res = await _authRepository.editProfile(
      uid: user.uid,
      firstName: firstName,
      lastName: lastName,
      profileImage: profileImage,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = _getDataSuccess(r);
        break;
    }
  }

  Future<void> updateDeviceToken({
    required String newDeviceToken,
  }) async {
    state = const AsyncValue.loading();

    final uid = ref.read(currentUserNotifierProvider)!.uid;

    final res = await _authRepository.updateDeviceToken(
      newDeviceToken: [newDeviceToken],
      uid: uid,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right(value: final r):
        state = _getDataSuccess(r);
        break;
    }
  }

  Future<AuthModel?> getData() async {
    state = const AsyncValue.loading();
    final uid = _authLocalRepository.getToken();

    if (uid != null) {
      final res = await _authRepository.getCurrentUserData(uid);
      final val = switch (res) {
        Left(value: final l) => state = AsyncValue.error(
            l.message,
            StackTrace.current,
          ),
        Right(value: final r) => _getDataSuccess(r),
      };
      print(val);
      return val!.value;
    }

    return null;
  }

  AsyncValue? _getDataSuccess(AuthModel user) {
    _authLocalRepository.setUid(user.uid);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final res = await _authRepository.logout();
    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(
          l.message,
          StackTrace.current,
        );
        break;

      case Right():
        state = const AsyncValue.data(unit);
        break;
    }
    await _authLocalRepository.removeToken();
  }
}
