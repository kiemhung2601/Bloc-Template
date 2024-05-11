import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/bloc/base_bloc.dart';
import '../../../core/config/injector.dart';
import '../../../data/provider/auth_provider.dart';
part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<_ChangeId>(_onIdTextFieldChanged);
    on<_ChangePassword>(_onPasswordTextFieldChanged);
    on<_Authenticate>(_onLoginButtonPressed, transformer: sequential());
  }

  final AuthProvider authProvider = getIt.get<AuthProvider>();

  FutureOr<void> _onIdTextFieldChanged(_ChangeId event, Emitter<LoginState> emit) {
    emit(state.copyWith(id: event.id));
  }

  FutureOr<void> _onPasswordTextFieldChanged(_ChangePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onLoginButtonPressed(_Authenticate event, Emitter<LoginState> emit) async {
    await runBlocCatching(
      action: () async => authProvider.signIn(state.id, state.password),
    );
  }
}
