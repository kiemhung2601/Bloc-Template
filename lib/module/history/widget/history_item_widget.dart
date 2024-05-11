import 'package:flutter/widgets.dart';

import '../../../core/extension/date_time_extesion.dart';
import '../../../core/theme/theme.dart';
import '../../../data/model/response/history.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({super.key, required this.history});
  final History history;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.appColors;

    return Container(
      decoration:
          BoxDecoration(color: colors.backgroundCard, borderRadius: const BorderRadius.all(Radius.circular(12))),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            history.title,
            style: AppStyles.s14w700Roboto,
          ),
          const SizedBox(height: 10),
          Text(
            history.description,
            style: AppStyles.s14w400Roboto,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              history.dateHis.toDateTimeNoSecondString,
              style: AppStyles.s14w400Roboto.copyWith(color: colors.textGrey),
            ),
          ),
        ],
      ),
    );
  }
}
