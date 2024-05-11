import 'package:flutter/material.dart';

import '../../../core/config/injector.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widget/widget.dart';
import '../bloc/home_bloc.dart';
import 'home_profile_menu.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultAppbar(actions: <Widget>[
      // AppMenuFloat(
      //   controller: getIt.get<DashboardBloc>().notificationController,
      //   margin: const EdgeInsets.only(right: 20),
      //   menuView: const DashboardNotificationMenu(),
      //   child: const AppIcon(AppIcons.notificationIcon, size: 36),
      // ),
      // IgnorePointer(
      //   child: AppMenuFloat(
      //     controller: getIt.get<DashboardBloc>().languageController,
      //     margin: const EdgeInsets.only(right: 20),
      //     menuView: const DashboardLanguageMenu(),
      //     child: const SizedBox(width: 20),
      //   ),
      // ),
      AppMenuFloat(
        controller: getIt.get<HomeBloc>().profileController,
        margin: const EdgeInsets.only(right: 20),
        menuView: const HomeProfileMenu(),
        child: const AppIcon(AppIcons.icProfile, size: 36),
      ),
      const SizedBox(width: 20),
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appbarHeight);
}
