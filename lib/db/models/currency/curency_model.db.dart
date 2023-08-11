import 'package:hive_flutter/hive_flutter.dart';
part 'curency_model.db.g.dart';

@HiveType(typeId: 3)
class CurrencyModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String cuntry;
  @HiveField(2)
  String symbol;
  CurrencyModel({required this.id, required this.cuntry, required this.symbol});
  toLowerCase() {}
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs