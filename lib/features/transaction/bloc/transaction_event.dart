part of 'transaction_bloc.dart';

abstract class TransactionEvent {}

class GetTransactionsEvent extends TransactionEvent {}

class AddTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  AddTransactionEvent({required this.transaction});
}

class EditTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  EditTransactionEvent({required this.transaction});
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;
  DeleteTransactionEvent({required this.id});
}

class SearchTransactionEvent extends TransactionEvent {
  final String text;
  SearchTransactionEvent({required this.text});
}
