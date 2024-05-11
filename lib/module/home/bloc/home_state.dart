part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    ProductPage? product,
    @Default([]) List<HomeMenu> lstMenu,
  }) = _HomeState;
}
