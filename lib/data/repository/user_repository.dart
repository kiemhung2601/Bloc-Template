import 'package:injectable/injectable.dart';
import '../model/response/user.dart';
import 'base_repository.dart';

@singleton
class UserRepository extends BaseRepository {
  const UserRepository() : super('/api/v1/users');

  // /// Sign in user into the system
  Future<User?> signIn(String id, String password) => apiService.postJson(
        '$path/auth/login',
        data: {'username': id, 'password': password, 'userType': 'CUSTOMER'},
        requiresAuthToken: false,
        converter: (data) => User.fromJson(data),
      );
}
