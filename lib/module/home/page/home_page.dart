import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_page_state.dart';
import '../../../core/extension/extenstion.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/widget/widget.dart';
import '../bloc/home_bloc.dart';
import '../widget/home_appbar.dart';
import '../widget/home_drawer.dart';
import '../widget/home_menu_widget.dart';
import '../widget/product_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const HomeEvent.loadMenu());
    bloc.add(const HomeEvent.loadProduct(14));
  }

  @override
  Widget buildPage(BuildContext context) {
    return DefaultScaffold(
      endDrawer: const HomeDrawer(),
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeMenuWidget(),
            _buildProduct(),
          ].applySeparator(const SizedBox(height: 16)),
        ),
      ),
    );
  }

  Widget _buildProduct() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.productSuggest,
                style: AppStyles.s14w700Roboto,
              ),
              const SizedBox(height: 16),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.product?.page.content.length ?? 0,
                  itemBuilder: (BuildContext context, int index) =>
                      ProductItemWidget(product: state.product!.page.content[index]),
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 5)),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildMenu() {
  //   return BlocBuilder<HomeBloc, HomeState>(
  //     builder: (context, state) {},
  //   );
  // }
}
