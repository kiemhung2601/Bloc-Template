part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.changeId(String id) = _ChangeId;

  const factory LoginEvent.changePassword(String password) = _ChangePassword;

  const factory LoginEvent.authenticate() = _Authenticate;
}
