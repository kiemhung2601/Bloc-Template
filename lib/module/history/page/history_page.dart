import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/base/base.dart';
import '../../../core/widget/widget.dart';
import '../../../data/model/response/history.dart';
import '../bloc/history_bloc.dart';
import '../widget/history_item_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends BasePageState<HistoryPage, HistoryBloc> {
  AppPagingController<History> pagingController = AppPagingController();

  @override
  void initState() {
    super.initState();
    pagingController.trigger(onLoadMore: (pageKey) => bloc.add(HistoryEvent.load(pageKey)));
  }

  @override
  bool handleListenWhen(CommonState previous, CommonState current) => true;

  @override
  void handleListener(BuildContext context, CommonState state) {
    state.whenOrNull(
      error: (exception) => pagingController.onError(exception),
      success: () => pagingController.onSuccess(bloc.state.items),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return DefaultScaffold(
      appBar: const DefaultAppbar(),
      body: RefreshIndicator.adaptive(
        onRefresh: pagingController.onRefresh,
        child: PagedListView<int, History>.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          pagingController: pagingController,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          builderDelegate: AppPagedChildBuilderDelegate<History>(itemBuilder: (context, History item, int index) {
            return Column(
              children: [
                Text(index.toString()),
                HistoryItemWidget(history: item),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget handleBuilder(BuildContext context, CommonState state) {
    return buildPage(context);
  }
}
