import 'package:flutter/material.dart';

class DefaultScrollbar extends StatelessWidget {
  const DefaultScrollbar({super.key, this.controller, required this.child});

  final ScrollController? controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 8,
      radius: const Radius.circular(10),
      child: child,
    );
  }
}
