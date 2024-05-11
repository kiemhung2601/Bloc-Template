import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../widget/view/progress_indicator.dart';
import 'bloc/base_bloc.dart';
import 'bloc/common/common_cubit.dart';
import 'bloc/mixin/log_mixin.dart';
import 'bloc/mixin/theme_mixin.dart';
import 'bloc/mixin/toast_mixin.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc> extends BasePageStateDelegate<T, B>
    with LogMixin, ThemeMixin, ToastMixin {}

abstract class BasePageStateDelegate<T extends StatefulWidget, B extends BaseBloc> extends State<T> {
  late final B bloc = GetIt.instance.get<B>();

  CommonState get status => bloc.commonCubit.state;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (bloc.autoClose) BlocProvider<B>(create: (_) => bloc) else BlocProvider<B>.value(value: bloc),
        BlocProvider<CommonCubit>(create: (_) => bloc.commonCubit),
      ],
      child: BlocConsumer<CommonCubit, CommonState>(
        bloc: bloc.commonCubit,
        listenWhen: handleListenWhen,
        listener: handleListener,
        buildWhen: handleBuildWhen,
        builder: handleBuilder,
      ),
    );
  }

  @protected
  bool handleListenWhen(CommonState previous, CommonState current) => current != previous;

  @protected
  bool handleBuildWhen(CommonState previous, CommonState current) => current != previous;

  @protected
  void handleListener(BuildContext context, CommonState state) {}

  @protected
  Widget handleBuilder(BuildContext context, CommonState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildPage(context),
        Visibility(
          visible: state.isLoading,
          child: const AppCircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget buildPage(BuildContext context);
}
