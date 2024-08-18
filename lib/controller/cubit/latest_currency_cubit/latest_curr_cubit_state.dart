part of 'latest_curr_cubit_cubit.dart';

abstract class LatestCurrCubitState {}

class LatestCurrCubitInitial extends LatestCurrCubitState {}

class LatestCurrWaiting extends LatestCurrCubitState {}

class FailurLoadedLatest extends LatestCurrCubitState {
  final String errorMessage;
  FailurLoadedLatest({required this.errorMessage});
}
class LatestRateSuccessLoaded extends LatestCurrCubitState {
  final CurrencyRatesModel currencyRatesModel;

  LatestRateSuccessLoaded(this.currencyRatesModel);
}