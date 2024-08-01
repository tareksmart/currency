part of 'add_currency_data_cubit.dart';
@immutable
abstract class AddCurrencyDataState {}

class AddCurrencyDataInitial extends AddCurrencyDataState {}

class AddCurrencyDataWaitingState extends AddCurrencyDataState {}

class AddCurrencyDataSuccess extends AddCurrencyDataState {}

class AddCurrencyDataFailure extends AddCurrencyDataState {
  final String errorMessage;

  AddCurrencyDataFailure({required this.errorMessage});
}
