import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widget/widget.dart';

class DashboardNavigation extends StatelessWidget {
  const DashboardNavigation({this.shell, super.key});

  final StatefulNavigationShell? shell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final int index = currentIndex(context);
    final double viewPaddingBottom = context.mediaQueryViewPadding.bottom;

    return Container(
      height: 100,
      padding: EdgeInsets.only(top: 2, bottom: 7 + viewPaddingBottom),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: context.appColors.divider))),
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardItem(
              icon: AppIcons.icHome,
              // lable: 'Trang chủ',
              lable: l10n.home,
              isSelected: index == 0,
              onPressed: () => goBranch(context, 0),
            ),
            DashboardItem(
              icon: AppIcons.icOrder,
              // lable: 'Lịch sử',
              lable: l10n.history,
              isSelected: index == 1,
              onPressed: () => goBranch(context, 1),
            ),
            DashboardItem(
              icon: AppIcons.icProfile,
              // lable: 'Menu',
              lable: l10n.menu,
              isSelected: index == 2,
              onPressed: () => goBranch(context, 2),
            ),
          ],
        ),
      ),
    );
  }

  int currentIndex(BuildContext context) {
    if (shell != null) return shell?.currentIndex ?? 0;

    return StatefulNavigationShell.maybeOf(context)?.currentIndex ?? 0;
  }

  void goBranch(BuildContext context, int index) {
    if (shell != null) return shell?.goBranch(index);

    return StatefulNavigationShell.maybeOf(context)?.goBranch(index);
  }
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.icon,
    required this.lable,
    this.isSelected = false,
    this.onPressed,
  });

  final String icon;
  final String lable;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          color: context.appColors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icon,
                colorFilter: isSelected ? AppIcon.fillColor(context.colorScheme.primary) : null,
              ),
              Text(lable, style: AppStyles.s10w400Roboto, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
