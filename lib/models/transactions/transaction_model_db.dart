import 'package:fin_trackr/models/account_group/account_group_model_db.dart';
import 'package:fin_trackr/models/category/category_model_db.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model_db.g.dart';

@HiveType(typeId: 6)
class TransactionModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final AccountType account;

  @HiveField(4)
  final CategoryType categoryType;

  @HiveField(5)
  final CategoryModel category;

  @HiveField(6)
  final String note;

  @HiveField(7)
  String? image;
  TransactionModel(
      {required this.id,
      required this.date,
      required this.account,
      required this.amount,
      required this.categoryType,
      required this.category,
      required this.note,
      this.image}) {
    // id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}
