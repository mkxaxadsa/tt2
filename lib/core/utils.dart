import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/transaction.dart';

bool onboard = true;
bool expanded = false;
String boxTarget = 'My car';
double boxAmount = 0;

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('onboard');
  onboard = prefs.getBool('onboard') ?? true;
  boxTarget = prefs.getString('boxTarget') ?? 'My box';
  boxAmount = prefs.getDouble('boxAmount') ?? 0;
}

Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboard', false);
}

Future<void> saveTarget(String target) async {
  final prefs = await SharedPreferences.getInstance();
  boxTarget = target;
  prefs.setString('boxTarget', target);
}

Future<void> saveBoxAmount(double value, bool plus) async {
  final prefs = await SharedPreferences.getInstance();
  if (plus) {
    boxAmount = boxAmount + value;
  } else {
    boxAmount = boxAmount - value;
  }
  prefs.setDouble('boxAmount', boxAmount);
}

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

String formatDateTime(DateTime date) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(date);
  return formattedDate;
}

DateTime convertToDateTime(String date) {
  return DateFormat('dd-MM-yyyy').parse(date);
}

String formatDateString(String date) {
  DateTime dateTime = DateFormat('dd-MM-yyyy').parse(date);
  String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
  return formattedDate;
}

String formatTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('HH:mm').format(dateTime);
}

String getTotalBalance() {
  double incomes = 0;
  double expenses = 0;
  for (Transaction transaction in mytransactions) {
    if (transaction.income) {
      incomes = incomes + transaction.amount;
    } else {
      expenses = expenses + transaction.amount;
    }
  }
  double total = incomes - expenses;
  return total.toStringAsFixed(0);
}

String getLastMonthSpendings() {
  double amount = 0;
  List<Transaction> lastMonthTransactions = [];
  DateTime now = DateTime.now();
  DateTime firstDayOfLastMonth = DateTime(now.year, now.month - 1, 1);
  for (Transaction transaction in mytransactions) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      transaction.id * 1000,
    );
    if (dateTime.isAfter(firstDayOfLastMonth)) {
      lastMonthTransactions.add(transaction);
    }
  }
  for (Transaction transaction in lastMonthTransactions) {
    if (!transaction.income) amount = amount + transaction.amount;
  }
  return amount.toStringAsFixed(0);
}

String getCategoryTotalAmount(String category) {
  double amount1 = 0;
  double amount2 = 0;
  double amount3 = 0;
  double amount4 = 0;
  for (Transaction transaction in mytransactions) {
    if (category == 'Travel' && transaction.category == category) {
      amount1 = amount1 + transaction.amount;
    }
    if (category == 'Shopping' && transaction.category == category) {
      amount2 = amount2 + transaction.amount;
    }
    if (category == 'Sport' && transaction.category == category) {
      amount3 = amount3 + transaction.amount;
    }
    if (category == 'Medicine' && transaction.category == category) {
      amount4 = amount4 + transaction.amount;
    }
  }
  if (category == 'Travel') return amount1.toStringAsFixed(0);
  if (category == 'Shopping') return amount2.toStringAsFixed(0);
  if (category == 'Sport') return amount3.toStringAsFixed(0);
  if (category == 'Medicine') return amount4.toStringAsFixed(0);
  return '0';
}

List<Transaction> mytransactions = [];

Future<List<Transaction>> getTransactions() async {
  final box = await Hive.openBox('transactionbox');
  List data = box.get('mytransactions') ?? [];
  mytransactions = data.cast<Transaction>();
  log(mytransactions.length.toString());
  calculateExpenses();
  return mytransactions;
}

Future<List<Transaction>> updateTransactions() async {
  final box = await Hive.openBox('transactionbox');
  box.put('mytransactions', mytransactions);
  mytransactions = await box.get('mytransactions');
  calculateExpenses();
  return mytransactions;
}

int w1e = 0;
int w2e = 0;
int w3e = 0;
int w4e = 0;
int w5e = 0;
int w6e = 0;
int w7e = 0;

int w1i = 0;
int w2i = 0;
int w3i = 0;
int w4i = 0;
int w5i = 0;
int w6i = 0;
int w7i = 0;

void calculateExpenses() {
  w1e = 0;
  w2e = 0;
  w3e = 0;
  w4e = 0;
  w5e = 0;
  w6e = 0;
  w7e = 0;

  w1i = 0;
  w2i = 0;
  w3i = 0;
  w4i = 0;
  w5i = 0;
  w6i = 0;
  w7i = 0;

  for (Transaction transaction in mytransactions) {
    DateTime date = convertToDateTime(transaction.date);
    log(date.toString());
    log(date.weekday.toString());
    if (transaction.income) {
      if (date.weekday == 1) w1i = w1i + transaction.amount.toInt();
      if (date.weekday == 2) w2i = w2i + transaction.amount.toInt();
      if (date.weekday == 3) w3i = w3i + transaction.amount.toInt();
      if (date.weekday == 4) w4i = w4i + transaction.amount.toInt();
      if (date.weekday == 5) w5i = w5i + transaction.amount.toInt();
      if (date.weekday == 6) w6i = w6i + transaction.amount.toInt();
      if (date.weekday == 7) w7i = w7i + transaction.amount.toInt();
    } else {
      if (date.weekday == 1) w1e = w1e + transaction.amount.toInt();
      if (date.weekday == 2) w2e = w2e + transaction.amount.toInt();
      if (date.weekday == 3) w3e = w3e + transaction.amount.toInt();
      if (date.weekday == 4) w4e = w4e + transaction.amount.toInt();
      if (date.weekday == 5) w5e = w5e + transaction.amount.toInt();
      if (date.weekday == 6) w6e = w6e + transaction.amount.toInt();
      if (date.weekday == 7) w7e = w7e + transaction.amount.toInt();
    }
  }
}

double getHeight(int a, int b) {
  if (a == 0) return 9;
  if (b == 0) return 9;
  if (a > b) return 80;
  return (a / b) * 80;
}
