import 'package:flutter/cupertino.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key, this.color, this.progress});

  final Color? color;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    Widget indicator;

    if (progress != null) {
      indicator = CupertinoActivityIndicator.partiallyRevealed(color: color, radius: 18, progress: progress!);
    } else {
      indicator = CupertinoActivityIndicator(color: color, radius: 18);
    }

    return indicator;
  }
}
