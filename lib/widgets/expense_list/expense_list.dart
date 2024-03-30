import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function (Expense expense) onRemoveExpense;

  @override
  Widget build (BuildContext context){
    return ListView.builder(itemCount: expenses.length,
     itemBuilder: (ctx, index) => Dismissible(
     key: ValueKey(expenses[index]), 
     child: ExpenseItem(expenses[index]),
     direction: DismissDirection.endToStart,
     background: Container(
      color:const Color.fromARGB(255, 211, 60, 47),
      margin: EdgeInsets.symmetric(horizontal: Theme.of(context) .cardTheme.margin!.horizontal,
       vertical: 12),
      ),
      onDismissed: (direction) {
      onRemoveExpense(expenses[index]);
     },
     ) 
     );
  }
}

  