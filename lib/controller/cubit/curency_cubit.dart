import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/currency_repository.dart';
import 'currency_states.dart';
import 'package:currencypro/model/currency_data.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyIntial());

  getAllCurrData() async {
    // await currRepo
    //     .getAllCurrency()
    //     .then((value) => emit(CurrenciesLoaded(value)));

    var currList = await CurrencyRepository().getAllCurrency();
    emit(CurrencyWaitingState());
    if (currList.isNotEmpty) {
      emit(CurrenciesLoaded(currList));
    }
    //print(currList);
  }

  getRates() async {
    var rates;
    rates=await CurrencyRepository().getAllRates();
   
    emit(RateLoaded(rates));
  }

  String price = '0';
  Future<void> getOneRates(String symbole) async {
    await CurrencyRepository().getOneRates(symbole).then((value) {
      emit(OneRateLoaded(value));
      price = value.rate!;
    });
  }

  void getNumber(String number) {
    emit(PressedNumber(number));
  }
}
