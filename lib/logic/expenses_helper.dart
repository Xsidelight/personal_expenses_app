import 'package:personal_expenses_app/data/expenses_list.dart';
import 'package:personal_expenses_app/data/models/expense_model.dart';

class ExpensesHelper {
  double totalExpenses() {
    double sum = 0;
    for (int i = 0; i < expensesList.length; i++) {
      sum += expensesList[i].amount;
    }
    return sum;
  }

  void addExpense(Expense expense) {
    expensesList.add(expense);
  }

  void deleteExpense(int id) {
    expensesList.removeWhere((element) => element.id == id);
  }

  List<Expense> get recentExpenses {
    return expensesList.where((expense) {
      return expense.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }
}
