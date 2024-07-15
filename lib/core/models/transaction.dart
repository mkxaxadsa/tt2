import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final int id;
  @HiveField(1)
  bool income;
  @HiveField(2)
  double amount;
  @HiveField(3)
  String date;
  @HiveField(4)
  String category;

  Transaction({
    required this.id,
    required this.income,
    required this.amount,
    required this.date,
    required this.category,
  });
}

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    return Transaction(
      id: reader.read(),
      income: reader.read(),
      amount: reader.read(),
      date: reader.read(),
      category: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer.write(obj.id);
    writer.write(obj.income);
    writer.write(obj.amount);
    writer.write(obj.date);
    writer.write(obj.category);
  }
}
