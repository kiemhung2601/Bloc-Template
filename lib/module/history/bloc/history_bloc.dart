import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/base/base.dart';
import '../../../data/model/response/history.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

@singleton
class HistoryBloc extends BaseBloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryState()) {
    on<_Started>((event, emit) {});
    on<_Load>(_onLoad);
  }

  FutureOr<void> _onLoad(_Load event, Emitter<HistoryState> emit) {
    return runBlocCatching<AppPagination<History>>(
      action: () async {
        await Future.delayed(const Duration(seconds: 1));
        return AppPagination<History>(
            data: List.filled(
              20,
              History(
                  title: 'Xin chào Faker',
                  description:
                      'Lee Sang-hyeok, được biết đến phổ biến với nghệ danh Faker, là một Game thủ chuyên nghiệp, thành viên, đội trưởng của đội tuyển thể thao điện tử T1 với tựa game Liên Minh Huyền Thoại.',
                  dateHis: DateTime.now()),
            ),
            pageNumber: event.page,
            totalElements: state.items.totalElements + 20);
      },
      doOnSuccess: (value) {
        emit(HistoryState(items: value));
      },
    );
  }
}
