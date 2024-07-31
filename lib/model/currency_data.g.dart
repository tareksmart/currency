// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyDataAdapter extends TypeAdapter<CurrencyData> {
  @override
  final int typeId = 0;

  @override
  CurrencyData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyData(
      currencyCode: fields[0] as String?,
      currencyName: fields[1] as String?,
      countryCode: fields[2] as String?,
      countryName: fields[3] as String?,
      status: fields[4] as String?,
      availableFrom: fields[5] as String?,
      availableUntil: fields[6] as String?,
      icon: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.currencyCode)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.countryCode)
      ..writeByte(3)
      ..write(obj.countryName)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.availableFrom)
      ..writeByte(6)
      ..write(obj.availableUntil)
      ..writeByte(7)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
