import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/data/models/expense_model.dart';
import 'package:personal_expenses_app/logic/expenses_helper.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({Key? key}) : super(key: key);


  @override
  _AddNewExpenseState createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();
  TextEditingController expensesTitleController = TextEditingController();
  TextEditingController expensesAmountController = TextEditingController();
  TextEditingController expensesIDController = TextEditingController();
  ExpensesHelper helper = ExpensesHelper();



  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020 - 12 - 31),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Theme.of(context).primaryColorDark)),
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: expensesTitleController,
                  decoration: const InputDecoration(
                    hintText: "Enter expense title",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid title";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Theme.of(context).primaryColorDark)),
                padding: const EdgeInsets.all(5),
                child:  TextFormField(
                  controller: expensesAmountController,
                  decoration: const InputDecoration(
                    hintText: "Enter expense amount",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid amount";
                    } else if (double.parse(value) <= 0) {
                      return "Amount can't be negative or equal to 0";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Theme.of(context).primaryColorDark)),
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: expensesIDController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Enter expense ID",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter valid ID";
                    } else if (double.parse(value) <= 0) {
                      return "ID can't be negative or equal to 0";
                    }
                    return null;
                  },
                ),
              ),
             const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                     DateFormat.yMMMd().format(dateTime),
                  ),
                  ElevatedButton(
                    onPressed: () => _showDatePicker(context),
                    child: const Text("Choose the date"),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Expense expense = Expense(
                        title: expensesTitleController.text,
                        amount: double.parse(expensesAmountController.text),
                        dateTime: dateTime,
                        id: int.parse(expensesIDController.text),
                      );
                      helper.addExpense(expense);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("SUBMIT"),
                  style: Theme.of(context).elevatedButtonTheme.style,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}