import 'package:flutter/material.dart';

import '../../extension/context_extension.dart';

class DefaultDivider extends StatelessWidget implements PreferredSizeWidget {
  const DefaultDivider({super.key, this.color, this.height = 1});

  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: color ?? context.appColors.divider);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class DefaultVerticalDivider extends StatelessWidget {
  const DefaultVerticalDivider({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size, child: VerticalDivider(width: 1, color: color ?? context.appColors.divider));
  }
}
