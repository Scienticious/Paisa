import 'package:flutter/material.dart';
import 'package:paisa/config/routes.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/enum/card_type.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/features/account/domain/entities/account_entity.dart';
import 'package:paisa/features/transaction/domain/entities/transaction_entity.dart';

class AccountCardV2 extends StatelessWidget {
  const AccountCardV2({
    super.key,
    required this.account,
    required this.transactions,
    this.onDelete,
    this.onTap,
  });

  final AccountEntity account;
  final List<TransactionEntity> transactions;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: Color(account.color));
    final Color color = colorScheme.primaryContainer;
    final Color onPrimary = colorScheme.onPrimaryContainer;
    final String expense = transactions.totalExpense.toFormateCurrency(context);
    final String income = transactions.totalIncome.toFormateCurrency(context);
    final String totalBalance =
        (account.amount + transactions.fullTotal).toFormateCurrency(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 242,
      child: PaisaFilledCard(
        color: color,
        child: InkWell(
          onTap: () {
            TransactionsByAccountPageData(accountId: account.superId!)
                .push(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                trailing: Icon(
                  account.cardType.icon,
                  color: onPrimary,
                ),
                title: Text(
                  account.name,
                  style: context.bodyMedium?.copyWith(
                    color: onPrimary,
                  ),
                ),
                subtitle: Text(
                  account.bankName,
                  style: context.bodyMedium?.copyWith(
                    color: onPrimary.withOpacity(0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  totalBalance,
                  style: context.headlineSmall?.copyWith(
                    color: onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  context.loc.thisMonth,
                  style: context.titleMedium?.copyWith(
                    color: onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ThisMonthTransactionWidget(
                      title: context.loc.income,
                      content: income,
                      color: onPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ThisMonthTransactionWidget(
                      title: context.loc.expense,
                      color: onPrimary,
                      content: expense,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ThisMonthTransactionWidget extends StatelessWidget {
  const ThisMonthTransactionWidget({
    super.key,
    required this.title,
    required this.content,
    required this.color,
  });

  final Color color;
  final String content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: context.titleMedium?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
