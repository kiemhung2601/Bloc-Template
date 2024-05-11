part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({@Default(false) bool isDisable}) = _RegisterState;
}
