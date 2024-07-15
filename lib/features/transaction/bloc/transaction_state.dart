part of 'transaction_bloc.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionsLoadedState extends TransactionState {
  final List<Transaction> transactions;
  TransactionsLoadedState({required this.transactions});
}
