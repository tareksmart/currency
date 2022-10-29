import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';

import '../../model/currency_data.dart';

abstract class CurrencyState {}

class CurrencyIntial extends CurrencyState {}

class CurrenciesLoaded extends CurrencyState {
  final List<CurrencyData> currencisList;

  CurrenciesLoaded(this.currencisList);
}

class RateLoaded extends CurrencyState {
  final CurrencyRate ratesList;

  RateLoaded(this.ratesList);
}

class OneRateLoaded extends CurrencyState {
  final OneRate rate;

  OneRateLoaded(this.rate);
}
