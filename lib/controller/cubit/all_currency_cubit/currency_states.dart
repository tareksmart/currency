import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';

import '../../../model/currency_data.dart';

abstract class CurrencyState {}

class CurrencyIntial extends CurrencyState {}

class CurrencyWaitingState extends CurrencyState {}

class CurrenciesLoaded extends CurrencyState {
  final List<CurrencyData> currencisList;
  CurrenciesLoaded(this.currencisList);
}

class FailurLoaded extends CurrencyState {
  final String errorMessage;

  FailurLoaded({required this.errorMessage});
}

class LatestCurrCubitInitial extends CurrencyState {}

class LatestCurrWaiting extends CurrencyState {}

class FailurLoadedLatest extends CurrencyState {
  final String errorMessage;
  FailurLoadedLatest({required this.errorMessage});
}
class LatestRateSuccessLoaded extends CurrencyState {
  final Map<String,dynamic> ratesList;

  LatestRateSuccessLoaded(this.ratesList);
}




