import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../module/auth/auth.dart';
import '../module/dashboard/dashboard.dart';
import '../module/history/history.dart';
import '../module/home/home.dart';
import '../module/profile/profile.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void goToHome() => const HomeRoute().go(rootNavigatorKey.currentContext!);
void goToLogin() => const LoginRoute().go(rootNavigatorKey.currentContext!);

@TypedGoRoute<InitalRoute>(path: '/')
class InitalRoute extends GoRouteData {
  @override
  String? redirect(BuildContext context, GoRouterState state) => const HomeRoute().location;
}

//AUTH
@TypedGoRoute<LoginRoute>(path: '/auth', routes: [
  TypedGoRoute<RegisterRoute>(path: 'register'),
])
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}

class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RegisterPage();
}

///DASHBOARD
@TypedStatefulShellRoute<DashboardShellRouteData>(
  branches: [
    TypedStatefulShellBranch<HomeBranch>(routes: [
      TypedGoRoute<HomeRoute>(path: '/home'),
    ]),
    TypedStatefulShellBranch<HistoryBranch>(routes: [
      TypedGoRoute<HistoryRoute>(path: '/history'),
    ]),
    TypedStatefulShellBranch<ProfileBranch>(routes: [
      TypedGoRoute<ProfileRoute>(path: '/profile', routes: [
        TypedGoRoute<InfoRoute>(path: 'info'),
        TypedGoRoute<SettingRoute>(path: 'setting'),
      ]),
    ]),
  ],
)
class DashboardShellRouteData extends StatefulShellRouteData {
  const DashboardShellRouteData();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return DashboardPage(navigationShell, state: state);
  }
}

class HomeBranch extends StatefulShellBranchData {
  const HomeBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = GlobalKey<NavigatorState>();
}

class HistoryBranch extends StatefulShellBranchData {
  const HistoryBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = GlobalKey<NavigatorState>();
}

class ProfileBranch extends StatefulShellBranchData {
  const ProfileBranch();

  static final GlobalKey<NavigatorState> $navigatorKey = GlobalKey<NavigatorState>();
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class HistoryRoute extends GoRouteData {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HistoryPage();
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

class InfoRoute extends GoRouteData {
  const InfoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InfoPage();
  }
}

class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingPage();
  }
}
