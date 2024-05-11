import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base/bloc/app_bloc_observer.dart';
import '../../core/config/config.dart';
import '../../core/config/injector.dart';
import '../../core/theme/theme.dart';
import '../../router/routing.dart';
import 'bloc/app_bloc.dart';
import 'page/error_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: getIt.get<AppBloc>(),
      builder: (context, state) {
        final isDarkTheme = state.themeMode == ThemeMode.dark ||
            state.themeMode == ThemeMode.system && context.platformBrightness == Brightness.dark;

        return AppThemeData(
            locale: state.locale,
            themeMode: state.themeMode,
            appColors: isDarkTheme ? AppColors.dark() : const AppColors.light(),
            child: Builder(builder: buildApp));
      },
    );
  }

  Widget buildApp(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      }),
      themeMode: AppThemeData.of(context).themeMode,
      theme: AppThemes.themeData,
      darkTheme: AppThemes.darkThemeData,
      locale: AppThemeData.of(context).locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, widget) {
        if (Config.enableErrorPage) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            if (widget is Scaffold || widget is Navigator || widget is Router) {
              return AppErrorPage(errorDetails);
            }
            return AppErrorrWidget(errorDetails, widget: widget);
          };
        }

        if (widget == null) {
          throw FlutterError('Widget is null');
        }

        return widget;
      },
      routerConfig: Routing.router,
    );
  }

  static Future<void> resolveDependencies() {
    Bloc.observer = AppBlocObserver();
    configureInjection();
    return getIt.allReady();
  }

  /// Copy FlutterNativeSplash optimize dependency
  static WidgetsBinding? _widgetsBinding;

  static void preserveSplash({required WidgetsBinding widgetsBinding}) {
    _widgetsBinding = widgetsBinding;
    _widgetsBinding?.deferFirstFrame();
  }

  static void removeSplash() {
    _widgetsBinding?.allowFirstFrame();
    _widgetsBinding = null;
  }
}
