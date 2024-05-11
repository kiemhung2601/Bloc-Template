part of 'common_cubit.dart';

@freezed
class CommonState with _$CommonState {
  const factory CommonState.loading() = _Loading;
  const factory CommonState.success() = _Success;
  const factory CommonState.error([Exception? exception]) = _Error;
  const factory CommonState.inital() = _Inital;

  const CommonState._();

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get isSuccess => maybeWhen(success: () => true, orElse: () => false);

  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

  bool get isInital => maybeWhen(inital: () => true, orElse: () => false);

  Exception? get exception => whenOrNull(error: (exception) => exception);
}
