// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curency_model.db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyModelAdapter extends TypeAdapter<CurrencyModel> {
  @override
  final int typeId = 3;

  @override
  CurrencyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyModel(
      id: fields[0] as String,
      cuntry: fields[1] as String,
      symbol: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cuntry)
      ..writeByte(2)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
