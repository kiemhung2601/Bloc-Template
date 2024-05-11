import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../../core/theme/theme.dart';
// import '../../../core/widget/button/app_text_button.dart';
import '../../../core/widget/widget.dart';
import '../../../router/router.dart';

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage(this.state, {super.key});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: const Text('Không tim thấy')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.error?.message ?? state.uri.toString(), textAlign: TextAlign.center),
            const AppTextButton(expandedWith: false, onPressed: goToHome, child: Text('Trở về home')),
          ],
        ),
      ),
    );
  }
}
