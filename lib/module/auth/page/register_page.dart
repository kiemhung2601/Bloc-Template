import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_page_state.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widget/widget.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BasePageState<RegisterPage, RegisterBloc> {
  @override
  Widget buildPage(BuildContext context) {
    final l10n = context.l10n;
    return DefaultScaffold(
      appBar: DefaultTitleAppbar(
        title: l10n.signUp,
      ),
      body: Center(
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return AppElevatedButton(
              primary: state.isDisable ? Colors.red : Colors.blue,
              child: Text(l10n.signUp),
              onPressed: () {
                bloc.add(RegisterEvent.changeButton(!state.isDisable));
              },
            );
          },
        ),
      ),
    );
  }
}
