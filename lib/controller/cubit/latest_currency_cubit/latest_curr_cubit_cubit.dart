import 'package:bloc/bloc.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/currency_rates_model.dart';
import 'package:currencypro/repo/currency_repository.dart';
import 'package:meta/meta.dart';

part 'latest_curr_cubit_state.dart';

class LatestCurrCubit extends Cubit<LatestCurrCubitState> {
  LatestCurrCubit() : super(LatestCurrCubitInitial());

  Future<void> getRates() async {
    emit(LatestCurrWaiting());

    var rates = await CurrencyRepository().getAllRates();
    //fold دالة تبع باكج ايثر
    rates.fold(
        (failur) => emit(FailurLoadedLatest(errorMessage: failur.errorMessage)),
        (currencyRate) => emit(LatestRateSuccessLoaded(currencyRate)));
  }
  
}
