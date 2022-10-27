import 'package:currencypro/model/currency_rate.dart';
import 'package:flutter/cupertino.dart';

import '../../model/currency_data.dart';


abstract class CurrencyState {}

class CurrencyIntial extends CurrencyState {}

class CurrenciesLoaded extends CurrencyState {
  final List<CurrencyData> currencisList;

  CurrenciesLoaded(this.currencisList);
}

class RateLoaded extends CurrencyState{
  final List<CurrencyRate> ratesList;

  RateLoaded(this.ratesList);
}
