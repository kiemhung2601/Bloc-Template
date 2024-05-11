part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;

  const factory HomeEvent.loadProduct(int idCategory) = _LoadProduct;

  const factory HomeEvent.loadMenu() = _LoadMenu;
}
