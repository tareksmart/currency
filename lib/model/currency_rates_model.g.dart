// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_rates_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyRatesModelAdapter extends TypeAdapter<CurrencyRatesModel> {
  @override
  final int typeId = 1;

  @override
  CurrencyRatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyRatesModel(
      base: fields[0] as String,
      date: fields[1] as String,
      rates: (fields[2] as Map).cast<String, double>(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyRatesModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.base)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.rates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyRatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
