part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String id,
    @Default('') String password,
  }) = _LoginState;
}
