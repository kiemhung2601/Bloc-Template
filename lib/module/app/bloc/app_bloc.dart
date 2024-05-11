import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/base.dart';
import '../../../core/utils/validate_utils.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';
part 'app_bloc.g.dart';

@singleton
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc._(super.initialState) {
    on<_ChangeThemeMode>(_onAppChangeThemeMode, transformer: sequential());
    on<_ChangeLocale>(_onAppChangeLocale, transformer: sequential());
  }

  FutureOr<void> _onAppChangeThemeMode(_ChangeThemeMode event, Emitter<AppState> emit) {
    emit.call(state.copyWith(themeModeIndex: event.themeMode.index));

    return _box.put(0, state);
  }

  FutureOr<void> _onAppChangeLocale(_ChangeLocale event, Emitter<AppState> emit) {
    emit.call(state.copyWith(languageCode: event.locale.languageCode));

    return _box.put(0, state);
  }

  @factoryMethod
  static Future<AppBloc> create() async {
    Hive.registerAdapter<AppState>(AppStateAdapter());
    _box = await Hive.openBox<AppState>('AppBloc');
    final AppState state = _box.get(0) ?? AppState();

    return AppBloc._(state);
  }

  static late Box<AppState> _box;
}
