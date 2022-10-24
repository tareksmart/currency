import 'package:flutter/cupertino.dart';

import '../../model/currency_data.dart';

@immutable
abstract class CurrencyState {}

class CurrencyIntial extends CurrencyState {}

class CurrenciesLoaded extends CurrencyState {
  final List<CurrencyData> currencisList;
  CurrenciesLoaded(this.currencisList);
}
