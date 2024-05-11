import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../extension/extenstion.dart';
import '../../theme/theme.dart';
import '../image/app_icon.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({
    super.key,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.only(top: 20),
    required this.items,
  });

  final Decoration? decoration;
  final EdgeInsetsGeometry padding, margin;
  final List<DefaultDrawerItem> items;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return Container(
      margin: margin,
      padding: padding,
      width: AppDimens.drawerWidth,
      decoration: decoration ?? BoxDecoration(color: colors.background, border: Border.all(color: colors.divider)),
      child: Stack(
        children: [
          _buildItems(context),
          Positioned(
            top: 0,
            right: 20,
            child: AppIcon.button(
              AppIcons.cancel,
              size: 22,
              onPressed: Navigator.of(context).maybePop,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemBuilder: (BuildContext context, int index) => items.elementAt(index),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
      itemCount: items.length,
    );
  }
}

class DefaultDrawerItem extends StatelessWidget {
  const DefaultDrawerItem({
    super.key,
    required this.icon,
    required this.lable,
    this.location,
    this.usePush = false,
    this.items = const <DefaultDrawerItem>[],
  });

  final String? icon, location;
  final String lable;
  final bool usePush;
  final List<DefaultDrawerItem> items;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (location != null) usePush ? GoRouter.of(context).push(location!) : GoRouter.of(context).go(location!);
          },
          child: buildItem(context),
        ),
        if (items.isNotEmpty) buildItemList(colors),
      ],
    );
  }

  Widget buildItem(BuildContext context) {
    return Row(
      children: [
        AppIcon(icon, size: 18),
        const SizedBox(width: 14),
        Expanded(child: Text(lable, style: AppStyles.s14w400Roboto, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget buildItemList(AppColors colors) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      decoration: BoxDecoration(color: colors.textFieldBackground, borderRadius: BorderRadius.circular(6)),
      child: ListView(
        padding: const EdgeInsets.all(14),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: items.applySeparator(const SizedBox(height: 10)),
      ),
    );
  }
}

class DefaultDrawerItemLever2 extends DefaultDrawerItem {
  const DefaultDrawerItemLever2({super.key, required super.lable, super.location, super.usePush}) : super(icon: null);

  @override
  Widget buildItem(BuildContext context) {
    final AppColors colors = context.appColors;

    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 13),
          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.dotMenu),
        ),
        Expanded(child: Text(lable, style: AppStyles.s14w400Roboto, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
