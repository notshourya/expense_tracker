import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses>createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses>{
final List<Expense> _registeredExpenses = [
 // Expense(title: 'Flutter Course', amount: 499.99, date: DateTime.now(), category: Category.clothing),
 // Expense(title: 'Cinema', amount: 699.99, date: DateTime.now(), category: Category.entertainment),
  ];
  
   void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
       builder: (ctx) => NewExpense(onaddExpense: _addExpense),
    );
   }

   void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
   }

   void _removeExpense(Expense expense) {

    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar (
      SnackBar(
      duration: const Duration(seconds: 5),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
       onPressed:() {
        setState(() { 
          _registeredExpenses.insert(expenseIndex, expense);  
        },
        );
       },
      ),
      ),
    );
   }
   
  @override
Widget build(BuildContext context) {
final width = MediaQuery.of(context).size.width;
  
  //print(_registeredExpenses);
  Widget mainContent = const Center(
    child: Text(
      'No Expenses added yet',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  if (_registeredExpenses.isNotEmpty) {
    mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
  }
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Expense Tracker',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
      ],
    ),
    body: width < 500 ? Column(
      children: [
        Chart(expenses: _registeredExpenses), // Ensure correct data is passed to Chart widget
        Expanded(
          child: mainContent,
        ),
      ],
    ) : Row(children:
      [Expanded( 
      child: Chart(expenses: _registeredExpenses),), 
        Expanded(
          child: mainContent,
        ),])
  );
}
}