import 'package:flutter/material.dart';
import 'package:personal_expenses_app/data/expenses_list.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/logic/expenses_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var totalExxpenses = ExpensesHelper().totalExpenses().toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expenses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Expenses:"),
                          Text(totalExxpenses),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 4,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  var currentExpense = expensesList[index];
                  return Card(
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
                  );
                },
                itemCount: expensesList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => Container(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
