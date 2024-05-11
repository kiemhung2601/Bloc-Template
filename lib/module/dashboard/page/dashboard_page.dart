import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/base.dart';
import '../../../core/widget/view/default_scaffold.dart';
import '../dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage(this.navigationShell, {super.key, required this.state});

  final GoRouterState state;
  final StatefulNavigationShell navigationShell;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends BasePageState<DashboardPage, DashboardBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const DashboardEvent.started());
  }

  @override
  Widget handleBuilder(BuildContext context, CommonState state) {
    return buildPage(context);
  }

  @override
  Widget buildPage(BuildContext context) {
    return DefaultScaffold(
      // endDrawer: const DashboardDrawer(),
      // appBar: const DashboardAppbar(),
      body: widget.navigationShell,
      bottomNavigationBar: DashboardNavigation(shell: widget.navigationShell),
    );
  }
}
