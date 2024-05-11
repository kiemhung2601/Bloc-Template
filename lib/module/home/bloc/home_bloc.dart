import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/base.dart';
import '../../../core/config/injector.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/utils/validate_utils.dart';
import '../../../core/widget/overlay/app_overlay.dart';
import '../../../data/model/response/home_menu.dart';
import '../../../data/model/response/product.dart';
import '../../../data/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@singleton
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<_Started>((event, emit) {});
    on<_LoadProduct>(_onLoadProduct);
    on<_LoadMenu>(_onLoadMenu);
  }

  @override
  bool get autoClose => false;

  final AppOverlayController profileController = AppOverlayController();

  final HomeRepository repository = getIt.get<HomeRepository>();

  FutureOr<void> _onLoadProduct(_LoadProduct event, Emitter<HomeState> emit) async {
    await runBlocCatching(
      action: () async {
        await Future.delayed(const Duration(seconds: 1));
        return const ProductPage(
            page: PageResponse(
          content: [
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
            Product(productName: 'Món ăn ngon', price: 100000, images: [
              'https://mauweb.monamedia.net/thegioididong/wp-content/uploads/2017/12/banner-Le-hoi-phu-kien-800-300.png'
            ]),
          ],
        ));
        // return repository.loadProduct(12);
      },
      doOnSuccess: (value) => emit.call(state.copyWith(product: value)),
      handleToast: false,
    );
  }

  FutureOr<void> _onLoadMenu(_LoadMenu event, Emitter<HomeState> emit) async {
    await runBlocCatching(
      action: () async {
        await Future.delayed(const Duration(seconds: 1));
        return [
          HomeMenu(icon: AppIcons.homeMenuFood, title: ValidateUtils.l10n.food),
          HomeMenu(icon: AppIcons.homeMenuCoconut, title: ValidateUtils.l10n.beverage),
          HomeMenu(icon: AppIcons.homeMenuAlcohol, title: ValidateUtils.l10n.alcohol),
          HomeMenu(icon: AppIcons.homeMenuApple, title: ValidateUtils.l10n.desserts)
        ];
      },
      doOnSuccess: (value) => emit.call(state.copyWith(lstMenu: value)),
      handleToast: false,
      handleLoading: false,
    );
  }
}
