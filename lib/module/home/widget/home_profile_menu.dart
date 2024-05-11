import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/extension/extenstion.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widget/widget.dart';

class HomeProfileMenu extends StatelessWidget {
  const HomeProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(text: l10n.hello, children: const [
            TextSpan(text: ' Kiếm Hùng', style: TextStyle(fontWeight: FontWeight.w400)),
          ]),
          style: AppStyles.s18w700Roboto,
        ),
        GestureDetector(
          onTap: () {
            // getIt.get<DashboardBloc>().profileController.hidenOverlay();
            // const SettingsRoute().push(context);
          },
          child: _buildItem(AppIcons.icProfile, l10n.information),
        ),
        GestureDetector(
          onTap: () {
            // final AppBloc appBloc = getIt.get<AppBloc>();
            // final ThemeMode themeMode = appBloc.state.themeMode;

            // appBloc.add(AppEvent.changeThemeMode(themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light));
          },
          child: _buildItem(AppIcons.icSetting, l10n.settings),
        ),
      ].applySeparator(const SizedBox(height: 16)),
    );
  }

  Widget _buildItem(String icon, String lable) {
    return Row(children: [
      AppIcon(icon, size: 34),
      const SizedBox(width: 12),
      Text(lable, style: AppStyles.s14w700Roboto),
      const Spacer(),
      const AppIcon(AppIcons.arrowRight, size: 14),
    ]);
  }
}
