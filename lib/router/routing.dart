import 'package:go_router/go_router.dart';

import '../core/config/config.dart';
import '../core/config/injector.dart';
import '../data/provider/auth_provider.dart';
import '../module/app/app.dart';
import '../module/app/page/error_route_page.dart';
import 'router.dart';

class Routing {
  const Routing._();

  static GoRouter router = GoRouter(
    debugLogDiagnostics: Config.enableNavigatorObserverLog,
    navigatorKey: rootNavigatorKey,
    initialLocation: const LoginRoute().location,
    refreshListenable: getIt.get<AuthProvider>().userRefresh(),
    routes: $appRoutes,
    errorBuilder: (context, GoRouterState state) => ErrorRoutePage(state),
    redirect: (context, GoRouterState state) async {
      final bool isAuthPath = state.fullPath?.startsWith(const LoginRoute().location) ?? false;
      final bool hasUser = getIt.get<AuthProvider>().user != null;

      if (!hasUser && !isAuthPath) {
        return const LoginRoute().location;
      }
      if (hasUser && isAuthPath) {
        return const HomeRoute().location;
      }

      Future.delayed(const Duration(seconds: 1), MyApp.removeSplash);

      return null;
    },
  );
}
