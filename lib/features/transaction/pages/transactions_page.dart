import 'package:flutter/material.dart';
import 'package:money4/core/utils.dart';

import '../../../core/widgets/page_title_card2.dart';
import '../widgets/expense_card.dart';
import '../widgets/transactions_list.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            PageTitleCard2(
              title: 'Transactions',
              subtitle: 'Your total spending over the\nlast month',
              amount: '\$${getLastMonthSpendings()}',
              height: 234,
            ),
            const SizedBox(height: 28),
            const Row(
              children: [
                SizedBox(width: 38),
                Text(
                  'Track your expenses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MontserratB',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 38),
                ExpenseCard(title: 'Travel'),
                SizedBox(width: 9),
                ExpenseCard(title: 'Shopping'),
                SizedBox(width: 38),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 38),
                ExpenseCard(title: 'Sport'),
                SizedBox(width: 9),
                ExpenseCard(title: 'Medicine'),
                SizedBox(width: 38),
              ],
            ),
          ],
        ),
        const TransactionsList(),
      ],
    );
  }
}
