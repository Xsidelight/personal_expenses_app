import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/data/models/expense_model.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.expenseList,
  }) : super(key: key);

  final List<Expense> expenseList;

  List<Map<String, dynamic>> get groupedExpensesValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < expenseList.length; i++) {
        if (expenseList[i].dateTime.day == weekDay.day &&
            expenseList[i].dateTime.month == weekDay.month &&
            expenseList[i].dateTime.year == weekDay.year) {
          totalSum += expenseList[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedExpensesValue.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedExpensesValue
                .map(
                  (e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: e['day'] as String,
                      spendingAmount: e['amount'] as double,
                      spendingPercentageOfTotal: totalSpending == 0
                          ? 0.0
                          : (e['amount'] as double) / totalSpending,
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }
}
