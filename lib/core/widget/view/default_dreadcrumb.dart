import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'default_divider.dart';

class DefaultBreadcrumb extends StatelessWidget implements PreferredSizeWidget {
  const DefaultBreadcrumb({
    super.key,
    this.padding = const EdgeInsets.only(left: 12, top: 30, bottom: 25),
    this.separator = ' > ',
    this.action,
    this.bottom = const DefaultDivider(),
    required this.crumbs,
  });

  final PreferredSizeWidget? bottom;
  final EdgeInsetsGeometry padding;
  final List<String> crumbs;
  final String separator;
  final Widget? action;

  @override
  Size get preferredSize => Size.fromHeight(34 + padding.vertical + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final String title = crumbs.last;

    return Column(
      children: [
        Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: AppStyles.s24w700Roboto),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text.rich(TextSpan(children: _buildItems(context).toList()), maxLines: 1),
                ),
              ),
              if (action != null) action!,
            ],
          ),
        ),
        if (bottom != null) bottom!,
      ],
    );
  }

  Iterable<InlineSpan> _buildItems(BuildContext context) sync* {
    final AppColors colors = context.appColors;
    final TextStyle style = AppStyles.s13w700Roboto.copyWith(color: colors.textGrey);

    yield TextSpan(text: '(', style: style);

    for (int i = 0; i < crumbs.length; i++) {
      if (i != 0) {
        yield TextSpan(text: separator, style: style);
      }

      yield TextSpan(text: crumbs[i], style: style);
    }

    yield TextSpan(text: ')', style: style);
  }
}
