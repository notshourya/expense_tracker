import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 98, 161, 255),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness:Brightness.dark,
  seedColor: const Color.fromARGB(255, 0, 149, 255), );
void main() { 
  runApp(
     MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: const Color.fromARGB(255, 13, 13, 13),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 26, 24, 24),
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.primaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(
        color: kDarkColorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        ),
      ),
      

      ),
      theme: ThemeData().copyWith(
      colorScheme: kColorScheme ,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.secondaryContainer,
      ),
      scaffoldBackgroundColor: kColorScheme.secondaryContainer,
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.primaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: kColorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
        color: kColorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        ),
      ),
      ),
      themeMode: ThemeMode.system,
      home:const Expenses(),
      ),
   );
} 