import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widget/widget.dart';
import '../bloc/home_bloc.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GridView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            mainAxisExtent: 85,
          ),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                border: Border.all(color: context.appColors.border),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIcon.button(
                  state.lstMenu[index].icon,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                Text(
                  state.lstMenu[index].title,
                  style: AppStyles.s14w400Roboto,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          itemCount: state.lstMenu.length,
        );
      },
    );
  }
}
