import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common_cubit.dart';
import 'mixin/event_transformer_mixin.dart';
import 'mixin/log_mixin.dart';
import 'mixin/toast_mixin.dart';

abstract class BaseBloc<Event, State> extends BaseBlocDelegate<Event, State> with EventTransformerMixin {
  BaseBloc(super.initialState);
}

abstract class BaseBlocDelegate<E, S> extends Bloc<E, S> with LogMixin, ToastMixin {
  BaseBlocDelegate(super.initialState);

  CommonCubit? _commonCubit;
  CommonCubit get commonCubit => _commonCubit ??= CommonCubit();

  /// Auto close [Bloc] in class [BasePageState]
  bool get autoClose => true;

  /// Notifies the [Bloc] of a new [event] which triggers all corresponding [EventHandler] instances.
  @override
  void add(E event) {
    if (!isClosed) {
      super.add(event);
    } else {
      logE('Cannot add new event $event because $runtimeType was closed');
    }
  }

  /// Change the state to error
  void addException(Exception? exception) => commonCubit.exceptionEmitted(exception);

  /// Change the state to loading state
  void showLoading() => commonCubit.loadingEmitted();

  /// Change the state to hiden loading
  void hideLoading({bool isSuccess = false}) => isSuccess ? commonCubit.successEmitted() : commonCubit.initalEmitted();

  /// Execute safety functions
  Future<void> runBlocCatching<T>({
    required Future<T> Function() action,
    FutureOr<void> Function()? doOnEventStart,
    FutureOr<void> Function(T value)? doOnSuccess,
    FutureOr<void> Function(Exception exception)? doOnError,
    FutureOr<void> Function()? doOnEventCompleted,
    bool handleLoading = true,
    bool handleError = true,
    bool handleToast = true,
  }) async {
    try {
      await doOnEventStart?.call();

      if (handleLoading) showLoading();

      final T value = await action.call();

      if (handleLoading) hideLoading(isSuccess: true);

      await doOnSuccess?.call(value);
    } on Exception catch (e) {
      if (handleLoading) hideLoading();

      await doOnError?.call(e);

      if (handleToast) addToastException(e);

      if (handleError) addException(e);
    } on Error catch (e) {
      if (handleLoading) hideLoading();

      if (handleToast) addToastMessage(Error.safeToString(e));

      if (handleError) addError(e, e.stackTrace);
    } finally {
      await doOnEventCompleted?.call();
    }
  }
}
