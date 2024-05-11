import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/bloc/base_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

@singleton
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<_Started>((event, emit) {});
    on<_ChangeButton>(_onChangeButton);
  }

  FutureOr<void> _onChangeButton(_ChangeButton event, Emitter<RegisterState> emit) {
    emit.call(RegisterState(isDisable: event.isDisable));
  }
}
