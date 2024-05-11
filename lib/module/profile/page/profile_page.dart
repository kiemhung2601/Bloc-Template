import 'package:flutter/material.dart';

import '../../../core/base/base_page_state.dart';
import '../../../core/config/injector.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/widget/widget.dart';
import '../../../data/provider/auth_provider.dart';
import '../../../router/router.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, ProfileBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return DefaultScaffold(
      appBar: DefaultTitleAppbar(
        title: context.l10n.information,
      ),
      body: Column(
        children: [
          AppTextButton(
            child: Text(l10n.settings),
            onPressed: () => const SettingRoute().go(context),
          ),
          const SizedBox(height: 16),
          AppTextButton(
            child: Text(l10n.information),
            onPressed: () => const InfoRoute().go(context),
          ),
          const SizedBox(height: 16),
          AppElevatedButton(
              child: Text(l10n.signOut),
              onPressed: () {
                getIt.get<AuthProvider>().logout();
              })
        ],
      ),
    );
  }
}
