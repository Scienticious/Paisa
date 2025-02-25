import 'package:flutter/material.dart';
import 'package:paisa/core/widgets/paisa_scaffold.dart';

import 'package:paisa/features/home/presentation/pages/summary/widgets/transaction_history_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/transaction_total_widget.dart';
import 'package:paisa/features/home/presentation/pages/summary/widgets/welcome_name_widget.dart';
import 'package:paisa/features/transaction/domain/entities/transaction_entity.dart';

class SummaryDesktopWidget extends StatelessWidget {
  const SummaryDesktopWidget({
    super.key,
    required this.expenses,
  });

  final List<TransactionEntity> expenses;

  @override
  Widget build(BuildContext context) {
    return PaisaScaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const WelcomeNameWidget(),
                    TransactionTotalWidget(transactions: expenses),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 124),
                  children: [
                    TransactionHistoryWidget(expenses: expenses),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
