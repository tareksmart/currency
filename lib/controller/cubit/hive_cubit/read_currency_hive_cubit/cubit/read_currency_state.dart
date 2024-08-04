part of 'read_currency_cubit.dart';

@immutable
class ReadCurrencyState {}

class ReadCurrencyInitial extends ReadCurrencyState {}

class ReadCurrencyWaitingState extends ReadCurrencyState {}

class ReadCurrencysuccessState extends ReadCurrencyState {
  final List<CurrencyData> currencyList;

  ReadCurrencysuccessState({required this.currencyList});
}

class ReadCurrencyfailureState extends ReadCurrencyState {
  final String errorMessage;

  ReadCurrencyfailureState({required this.errorMessage});
}
