import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/transaction.dart';
import '../../../core/utils.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  List<Transaction> _transactions = [];

  TransactionBloc() : super(TransactionInitial()) {
    on<GetTransactionsEvent>((event, emit) async {
      if (mytransactions.isEmpty) {
        _transactions = await getTransactions();
        emit(TransactionsLoadedState(transactions: _transactions));
      } else {
        emit(TransactionsLoadedState(transactions: _transactions));
      }
    });

    on<AddTransactionEvent>((event, emit) async {
      mytransactions.add(event.transaction);
      _transactions = await updateTransactions();
      emit(TransactionsLoadedState(transactions: _transactions));
    });

    on<EditTransactionEvent>((event, emit) async {
      for (Transaction transaction in mytransactions) {
        if (transaction.id == event.transaction.id) {
          transaction.income = event.transaction.income;
          transaction.amount = event.transaction.amount;
          transaction.date = event.transaction.date;
          transaction.category = event.transaction.category;
        }
      }

      _transactions = await updateTransactions();

      emit(TransactionsLoadedState(transactions: _transactions));
    });

    on<DeleteTransactionEvent>((event, emit) async {
      mytransactions.removeWhere((element) => element.id == event.id);
      _transactions = await updateTransactions();
      emit(TransactionsLoadedState(transactions: _transactions));
    });

    on<SearchTransactionEvent>((event, emit) async {
      List<Transaction> suggestionList = event.text.isEmpty
          ? mytransactions
          : mytransactions.where((item) {
              return item.category
                      .toLowerCase()
                      .contains(event.text.toLowerCase()) ||
                  item.amount.toString().contains(event.text.toLowerCase()) ||
                  item.date.contains(event.text.toLowerCase());
            }).toList();
      emit(TransactionsLoadedState(transactions: suggestionList));
    });
  }
}
