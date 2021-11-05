import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/expenses_list.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/logic/expenses_helper.dart';
import 'package:personal_expenses_app/presentation/widgets/add_expense_widget.dart';
import 'package:personal_expenses_app/presentation/widgets/chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var totalExxpenses = ExpensesHelper().totalExpenses().toString();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Personal Expenses",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Total Expenses:'),
            Text(
              '\$$totalExxpenses',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Chart(expenseList: expensesList),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 4,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  var currentExpense = expensesList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        ExpensesHelper().deleteExpense(currentExpense.id);
                      });
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (index + 1).toString(),
                          ),
                        ),
                        title: Text(
                          currentExpense.title,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(currentExpense.dateTime),
                        ),
                        trailing: Text(currentExpense.amount.toString()),
                      ),
                    ),
                  );
                },
                itemCount: expensesList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS ? null : FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => const AddNewExpense(),
        ).then((_) {
          setState(() {});
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
