// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseDataAdapter extends TypeAdapter<ExpenseData> {
  @override
  final int typeId = 4;

  @override
  ExpenseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as IconData,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
