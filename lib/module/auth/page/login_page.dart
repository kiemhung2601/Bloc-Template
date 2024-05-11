import 'package:flutter/material.dart';

import '../../../core/base/base_page_state.dart';
import '../../../core/base/bloc/common/common_cubit.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/validate_utils.dart';

import '../../../core/widget/widget.dart';
import '../../../router/router.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget buildPage(BuildContext context) {
    ValidateUtils.l10n = l10n;
    final textStyle = AppStyles.s13w400Roboto.copyWith(color: appThemes.appColors.textGrey);
    return Form(
      key: formKey,
      child: DefaultScaffold(
        appBar: DefaultTitleAppbar(title: l10n.signIn),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 35, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const SizedBox(height: 31),
                ..._buildInputIdentifyPasswordWidget(textStyle),
                const SizedBox(height: 31),
                _buildActions(),
                const SizedBox(height: 20),
                // _buildForgotPasswordWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AppElevatedButton(
            isLoading: status.isLoading,
            borderRadius: BorderRadius.circular(12),
            child: Text(l10n.signIn),
            onPressed: () {
              formKey.currentState?.save();
              if (formKey.currentState?.validate() ?? false) {
                bloc.add(const LoginEvent.authenticate());
              }
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppOutlinedButton(
            borderRadius: BorderRadius.circular(10),
            primary: appThemes.appColors.buttonOulineBoderBlur,
            child: Text(l10n.signUp, style: AppStyles.s14w400Roboto.copyWith(color: appThemes.appColors.primary)),
            onPressed: () => const RegisterRoute().go(context),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildInputIdentifyPasswordWidget(TextStyle textStyle) {
    return [
      Text(l10n.username, style: textStyle),
      const SizedBox(height: 6),
      AppTextFormField(
        onChanged: (value) => bloc.add(LoginEvent.changeId(value)),
        hintText: l10n.hintUsername,
        // validator: ValidateUtils.validIdentity,
        contentPadding: const EdgeInsets.all(10).copyWith(left: 15),
      ),
      const SizedBox(height: 26.5),
      Text(l10n.password, style: textStyle),
      const SizedBox(height: 6),
      AppTextPasswordField(
        onChanged: (value) => bloc.add(LoginEvent.changePassword(value)),
        hintText: l10n.hintPassword,
        // validator: ValidateUtils.validPassword,
        contentPadding: const EdgeInsets.all(10).copyWith(left: 15),
      )
    ];
  }

  @override
  Widget handleBuilder(BuildContext context, CommonState state) {
    return buildPage(context);
  }

  @override
  bool handleListenWhen(CommonState previous, CommonState current) => current.isSuccess;
}
