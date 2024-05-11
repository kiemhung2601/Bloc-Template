import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/base.dart';
import '../../../core/widget/widget.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

@singleton
class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<_Started>(_onStarted);
  }

  @override
  bool get autoClose => false;

  final AppOverlayController notificationController = AppOverlayController();
  final AppOverlayController languageController = AppOverlayController();
  final AppOverlayController profileController = AppOverlayController();

  // Future<void> _onStarted(_Started event, Emitter<DashboardState> emit) => runBlocCatching(
  //       handleLoading: false,
  //       doOnEventStart: () {},
  //       action: () {
  //         return _;
  //       },
  //     );

  FutureOr<void> _onStarted(_Started event, Emitter<DashboardState> emit) {}
}
