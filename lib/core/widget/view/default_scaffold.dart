import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    super.key,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = true,
    this.actionOnTapOutside,
  });

  final PreferredSizeWidget? appBar;
  final Widget? drawer, endDrawer;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;
  final VoidCallback? actionOnTapOutside;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? colors.background,
      body: body,
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      drawerScrimColor: Colors.transparent,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () {
              _hideKeyboard(context);
              if (actionOnTapOutside != null) {
                actionOnTapOutside!();
              }
            },
            child: scaffold,
          )
        : scaffold;
  }

  static void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) FocusManager.instance.primaryFocus?.unfocus();
  }
}
