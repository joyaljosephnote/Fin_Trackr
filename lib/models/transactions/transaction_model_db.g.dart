// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 6;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      id: fields[0] as int?,
      date: fields[1] as String,
      account: fields[3] as AccountType,
      amount: fields[2] as double,
      categoryType: fields[4] as CategoryType,
      category: fields[5] as CategoryModel,
      note: fields[6] as String,
      image: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.account)
      ..writeByte(4)
      ..write(obj.categoryType)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
