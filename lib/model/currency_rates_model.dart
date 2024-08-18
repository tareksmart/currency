import 'package:hive/hive.dart';
part 'currency_rates_model.g.dart';
@HiveType(typeId: 1)
class CurrencyRatesModel extends HiveObject{
  @HiveField(0)
  final String base;
  @HiveField(1)

  final String date;
  @HiveField(2)

  final Map<String, dynamic> rates;

  CurrencyRatesModel({
    required this.base,
    required this.date,
    required this.rates,
  });

  factory CurrencyRatesModel.fromJson(Map<String, dynamic> json) {
    return CurrencyRatesModel(
      base: json['base'] as String,
      date: json['date'] as String,
      rates: Map.from(json['rates'])
          .map((key, value) => MapEntry(key, value)),
    );
  }
}
