import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../core/base/base.dart';
import '../../../core/config/injector.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widget/widget.dart';
import '../../app/bloc/app_bloc.dart';
import '../bloc/setting_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage, SettingBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return DefaultScaffold(
      appBar: DefaultTitleAppbar(
        leading: AppIcon.button(AppIcons.icArrowBack, onPressed: context.pop),
        title: context.l10n.settings,
      ),
      body: Column(
        children: [
          AppTextButton(
            child: Text(l10n.system),
            onPressed: () => getIt.get<AppBloc>().add(const AppEvent.changeThemeMode(ThemeMode.system)),
          ),
          AppTextButton(
            child: Text(l10n.dark),
            onPressed: () => getIt.get<AppBloc>().add(const AppEvent.changeThemeMode(ThemeMode.dark)),
          ),
          AppTextButton(
            child: Text(l10n.light, style: AppStyles.s10w400Roboto),
            onPressed: () => getIt.get<AppBloc>().add(const AppEvent.changeThemeMode(ThemeMode.light)),
          ),
          const SizedBox(height: 40),
          ...AppLocalizations.supportedLocales.map(
            (e) => AppTextButton(
              child: Text(AppState.localeText(e)),
              onPressed: () => getIt.get<AppBloc>().add(AppEvent.changeLocale(e)),
            ),
          )
        ],
      ),
    );
  }
}
