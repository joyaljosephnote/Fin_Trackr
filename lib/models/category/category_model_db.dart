import 'package:hive_flutter/hive_flutter.dart';
part 'category_model_db.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool isDeleted;
  @HiveField(3)
  CategoryType categoryType;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.isDeleted,
      required this.categoryType}) {
    // id = DateTime.now().microsecondsSinceEpoch.toString();
  }

  toLowerCase() {}
}


// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs