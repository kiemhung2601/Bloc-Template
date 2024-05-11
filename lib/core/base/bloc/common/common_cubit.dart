import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_state.dart';
part 'common_cubit.freezed.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit() : super(const CommonState.inital());

  void loadingEmitted() => emit(const CommonState.loading());

  void exceptionEmitted([Exception? exception]) => emit(CommonState.error(exception));

  void successEmitted() => emit(const CommonState.success());

  void initalEmitted() => emit(const CommonState.inital());
}
