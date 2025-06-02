import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sis/features/auth/models/auth_model.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  AuthModel? build() {
    return null;
  }

  void addUser(AuthModel user) {
    state = user;
  }
}
