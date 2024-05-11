import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/widget/widget.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: DefaultTitleAppbar(
          title: context.l10n.information, leading: AppIcon.button(AppIcons.icArrowBack, onPressed: context.pop)),
      body: const Center(
        child: Text('INFO PAGE'),
      ),
    );
  }
}
