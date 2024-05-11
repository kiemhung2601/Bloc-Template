import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widget/widget.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;
    final AppLocalizations l10n = context.l10n;
    final EdgeInsets viewPadding = context.mediaQueryViewPadding;

    return DefaultDrawer(
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(top: BorderSide(color: colors.divider), left: BorderSide(color: colors.divider)),
      ),
      margin: viewPadding.add(const EdgeInsets.only(bottom: AppDimens.navigationBarHeight)),
      items: <DefaultDrawerItem>[
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          // location: const WarehouseSearchRoute().location,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          items: [
            DefaultDrawerItemLever2(
              lable: l10n.settings,
              // location: const PurchaseRoute().location,
            ),
            DefaultDrawerItemLever2(
              lable: l10n.settings,
              // location: const PurchaseStatusInquiryRoute().location,
            ),
            DefaultDrawerItemLever2(
              lable: l10n.settings,
              // location: const PurchaseDeliveryDateInquiryRoute().location,
            ),
            DefaultDrawerItemLever2(
              lable: l10n.settings,
              // location: const PurchaseROPManagementRoute().location,
            ),
            DefaultDrawerItemLever2(
              lable: l10n.settings,
              // location: const PurchaseReturnRegistrationRoute().location,
              usePush: true,
            ),
          ],
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          // location: const InventoryReceivingAndForwardingRoute().location,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          // location: const BusinessPartnerSearchRoute().location,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          // location: const UnitPriceManagementRoute().location,
        ),
        DefaultDrawerItem(
          icon: AppIcons.board,
          lable: l10n.settings,
          items: [
            DefaultDrawerItem(
              icon: AppIcons.board,
              lable: l10n.settings,
              // location: const StockAdjustmentRoute(StockAdjustmentMode.stockAdjustment).location,
            ),
            DefaultDrawerItem(
              icon: AppIcons.board,
              lable: l10n.settings,
              // location: const StockAdjustmentRoute(StockAdjustmentMode.stockMovementBetweenWarehouse).location,
            ),
            DefaultDrawerItem(
              icon: AppIcons.board,
              lable: l10n.settings,
              // location: const StockInquiryPresentHistoryRoute(StockInquiryPresentHistoryMode.present).location,
            ),
            DefaultDrawerItem(
              icon: AppIcons.board,
              lable: l10n.settings,
              // location: const StockInquiryPresentHistoryRoute(StockInquiryPresentHistoryMode.history).location
            )
          ],
        ),
      ],
    );
  }
}
