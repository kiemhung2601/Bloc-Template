import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class AppErrorPage extends StatelessWidget {
  const AppErrorPage(this.errorDetails, {super.key});

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bug_report, size: 50),
          Text(_stringify(errorDetails.exception), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  static String _stringify(Object? exception) {
    try {
      return exception.toString();
    } catch (_) {}
    return 'Error';
  }
}

class AppErrorrWidget extends StatelessWidget {
  const AppErrorrWidget(this.errorDetails, {super.key, this.widget});

  final FlutterErrorDetails errorDetails;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Placeholder(child: Icon(Icons.bug_report, color: context.colorScheme.error, size: 50));
  }
}
