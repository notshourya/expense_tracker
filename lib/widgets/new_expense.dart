import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onaddExpense});

  final void Function(Expense expense) onaddExpense;

  @override
  State<NewExpense> createState() => _NewExpense();
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('Please enter a valid Title, Amount and Date'),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid Title, Amount and Date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();

      return;
    }
    widget.onaddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(
                              () {
                                _selectedCategory = value;
                              },
                            );
                          },
                        ),
                        SizedBox(width: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'Select Date'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate == null
                                  ? 'Select Date'
                                  : formatter.format(_selectedDate!)),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _selectedCategory = value;
                              });
                            }),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _submitExpenseData();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                ],
              )),
        ),
      );
    });
  }
}
