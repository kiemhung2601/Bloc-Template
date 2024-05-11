import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../core/config/injector.dart';
import '../model/response/user.dart';
import '../repository/user_repository.dart';
import 'base_provider.dart';

@singleton
class AuthProvider extends BaseProvider<UserRepository> {
  AuthProvider() {
    Hive.registerAdapter<User>(UserAdapter());
  }

  static const String _keyToken = 'AuthProvider.token';
  static const String _keyUser = 'AuthProvider.user';

  Future<String?> getAuthToken() => storage.getEncrypted(_keyToken);

  Future<User> fetchUser() async {
    await storage.saveItem<User>(_keyUser, User());

    return user!;
  }

  User? get user => storage.getItem<User>(_keyUser);

  Listenable userRefresh() => storage.listenable(keys: [_keyUser]);

  Future<void> logout() {
    storage.clear();
    return storage.clearEncrypted();
  }

  Future signIn(String id, String password) async {
    final user = await getIt.get<UserRepository>().signIn(id, password);
    // final user = User();
    await storage.saveItem<User>(_keyUser, user);
    await fetchUser();
  }

  Future signUp(User user) async {
    final Map<String, dynamic> data = user.toJson();
    data.removeWhere((key, value) => value == null);
  }

  Future saveToken(String token) async {
    await storage.saveEncrypted(_keyToken, token);
    await fetchUser();
  }
}
