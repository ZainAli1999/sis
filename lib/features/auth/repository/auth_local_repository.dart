import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setUid(String? uid) {
    if (uid != null) {
      _sharedPreferences.setString('uid', uid);
    }
  }

  String? getToken() {
    return _sharedPreferences.getString('uid');
  }

  Future<void> removeToken() {
    return _sharedPreferences.remove('uid');
  }
}
