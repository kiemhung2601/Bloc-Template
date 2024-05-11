import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../image/app_icon.dart';
import '../input/app_text_search_field.dart';
import 'default_divider.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppbar({
    super.key,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.actions,
    this.bottom = const DefaultDivider(),
  });

  final bool automaticallyImplyLeading;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(AppDimens.appbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      backgroundColor: colors.background,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: _buildLeadingAppBar(context),
      leadingWidth: AppDimens.appbarLeadingSize + AppDimens.appbarLeadingPading.horizontal,
      toolbarHeight: preferredSize.height,
      // titleSpacing: 0,
      title: AppIcon.rect(
        AppIcons.icFoodLogo,
        height: 30,
        width: null,
        colorFilter: AppIcon.fillColor(colors.foreground),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  Widget? _buildLeadingAppBar(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);

    if (scaffold?.hasDrawer ?? false) {
      return AppIcon.button(
        AppIcons.icMenu,
        colorFilter: AppIcon.fillColor(context.appColors.foreground),
        size: AppDimens.appbarLeadingSize,
        padding: AppDimens.appbarLeadingPading,
        onPressed: scaffold?.openDrawer,
      );
    }

    return leading;
  }
}

class DefaultTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultTitleAppbar({
    super.key,
    this.title = '',
    this.useCloseButton = false,
    this.leading,
    this.actions,
    this.bottom,
  });

  final bool useCloseButton;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(AppDimens.appbarTitleHeight + 15 + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: colors.background,
      toolbarHeight: preferredSize.height,
      leadingWidth: AppDimens.appbarLeadingSize + AppDimens.appbarLeadingPading.horizontal,
      leading: useCloseButton ? null : buildLeadingAppBar(context),
      titleSpacing: 10,
      title: Text(
        title,
        style: AppStyles.s24w700Roboto.copyWith(color: colors.textBlack),
        // textScaleFactor: AppStyles.textScaleFactor(context),
      ),
      actions: [
        ...?actions,
        if (useCloseButton) buildLeadingAppBar(context) ?? const SizedBox(width: 10),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15 + (bottom?.preferredSize.height ?? 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (bottom != null) bottom!,
            const SizedBox(height: 14),
            const DefaultDivider(), // preferredSize: 1 + 14 = 15
          ],
        ),
      ),
    );
  }

  Widget? buildLeadingAppBar(BuildContext context) {
    if (leading != null) return leading;

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    if (scaffold?.hasDrawer ?? false) {
      return AppIcon.button(
        AppIcons.icMenu,
        colorFilter: AppIcon.fillColor(context.appColors.foreground),
        size: AppDimens.appbarLeadingSize,
        padding: AppDimens.appbarLeadingPading,
        onPressed: scaffold?.openDrawer,
      );
    }

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    if (parentRoute?.impliesAppBarDismissal ?? false) {
      if (useCloseButton) {
        return AppIcon.button(
          AppIcons.icClear,
          size: AppDimens.appbarActionSize,
          padding: AppDimens.appbarActionPading,
          colorFilter: AppIcon.fillColor(context.appColors.foreground),
          onPressed: Navigator.of(context).maybePop,
        );
      }

      return AppIcon.button(
        AppIcons.icArrowBack,
        size: AppDimens.appbarLeadingSize,
        padding: AppDimens.appbarLeadingPading,
        colorFilter: AppIcon.fillColor(context.appColors.foreground),
        onPressed: Navigator.of(context).maybePop,
      );
    }

    return null;
  }
}

class DefaultAppbarSearch extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppbarSearch({
    super.key,
    this.title = '',
    this.useCloseButton = false,
    this.useTopDivider = true,
    this.useDefaultSuffixSearchIcon = true,
    this.leading,
    this.bottom,
    this.paddingHeader = const EdgeInsets.fromLTRB(0, 30, 12, 30),
    this.action,
    this.suffixIconSearch,
    this.paddingBottom,
    this.searchHint,
  });

  final bool useCloseButton;
  final bool useTopDivider;
  final bool useDefaultSuffixSearchIcon;

  final String title;
  final String? searchHint;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final EdgeInsets paddingHeader;
  final EdgeInsets? paddingBottom;
  final List<Widget>? action;

  final Widget? suffixIconSearch;

  double get padLeft => paddingHeader.left;
  double get padTop => paddingHeader.top;
  double get padRight => paddingHeader.right;
  double get padBottom => paddingHeader.bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(AppDimens.appbarHeight * 2 + padTop + padBottom - 20 + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: colors.background,
      toolbarHeight: preferredSize.height,
      leading: leading,
      titleSpacing: leading == null ? 10 : 0,
      title: Padding(
        padding: EdgeInsets.only(left: padLeft, right: padRight),
        child: Text(
          title,
          style: AppStyles.s24w700Roboto.copyWith(color: colors.textBlack),
          // textScaleFactor: AppStyles.textScaleFactor(context),
        ),
      ),
      actions: [...action ?? [], const SizedBox(width: 12)],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15 + (bottom?.preferredSize.height ?? 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (useTopDivider) ...[const DefaultDivider(), const SizedBox(height: 14)] else Container(),
            Padding(
              padding: paddingBottom ?? EdgeInsets.zero,
              child: AppTextSearchField(
                onFieldSubmitted: (key) {},
                hintText: searchHint ?? context.l10n.search,
                suffixIcon: suffixIconSearch,
                suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
            const SizedBox(height: 14),
            const DefaultDivider(), // preferredSize: 1 + 14 = 15
          ],
        ),
      ),
    );
  }

  Widget? buildLeadingAppBar(BuildContext context) {
    if (leading != null) return leading;

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    if (scaffold?.hasDrawer ?? false) {
      return AppIcon.button(
        AppIcons.icMenu,
        colorFilter: AppIcon.fillColor(context.appColors.foreground),
        size: AppDimens.appbarLeadingSize,
        padding: AppDimens.appbarLeadingPading,
        onPressed: scaffold?.openDrawer,
      );
    }

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    if (parentRoute?.impliesAppBarDismissal ?? false) {
      if (useCloseButton) {
        return AppIcon.button(
          AppIcons.icClear,
          size: AppDimens.appbarActionSize,
          padding: AppDimens.appbarActionPading,
          colorFilter: AppIcon.fillColor(context.appColors.foreground),
          onPressed: Navigator.of(context).maybePop,
        );
      }

      return AppIcon.button(
        AppIcons.icArrowBack,
        size: AppDimens.appbarLeadingSize,
        padding: AppDimens.appbarLeadingPading,
        colorFilter: AppIcon.fillColor(context.appColors.foreground),
        onPressed: Navigator.of(context).maybePop,
      );
    }

    return null;
  }
}

class DefaultSubAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultSubAppbar({
    super.key,
    this.title = '',
    this.leading,
    this.bottom,
    this.padding = const EdgeInsets.fromLTRB(0, 30, 12, 30),
    this.action,
  });

  final String title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final EdgeInsets padding;
  final List<Widget>? action;

  double get paddingLeft => padding.left;
  double get paddingTop => padding.top;
  double get paddingRight => padding.right;
  double get paddingBottom => padding.bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(AppDimens.appbarTitleHeight + paddingTop + paddingBottom + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: colors.background,
      toolbarHeight: preferredSize.height,
      leading: leading,
      titleSpacing: leading == null ? 10 : 0,
      title: Padding(
        padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
        child: Text(
          title,
          style: AppStyles.s24w700Roboto.copyWith(color: colors.textBlack),
          // textScaleFactor: AppStyles.textScaleFactor(context),
        ),
      ),
      actions: [...action ?? [], const SizedBox(width: 12)],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15 + (bottom?.preferredSize.height ?? 0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (bottom != null) bottom!,
            if (bottom != null) const SizedBox(height: 14),
            const DefaultDivider(), // preferredSize: 1 + 14 = 15
          ],
        ),
      ),
    );
  }
}
