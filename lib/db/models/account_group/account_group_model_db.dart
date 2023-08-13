import 'package:hive_flutter/hive_flutter.dart';
part 'account_group_model_db.g.dart';

@HiveType(typeId: 5)
enum AccountType {
  @HiveField(0)
  cash,
  @HiveField(1)
  account,
}

@HiveType(typeId: 4)
class AccountGroupModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double? amount;
  @HiveField(3)
  AccountType accountType;
  AccountGroupModel({
    required this.id,
    required this.name,
    this.amount,
    required this.accountType,
  });
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs