import 'package:flutter_bloc/flutter_bloc.dart';

import '../currency_repository.dart';
import 'currency_states.dart';
import 'package:currencypro/model/currency_data.dart';

class CurrencyCubit extends Cubit<CurrencyState> {

  CurrencyCubit() : super(CurrencyIntial());

   getAllCurrData() async {

    // await currRepo
    //     .getAllCurrency()
    //     .then((value) => emit(CurrenciesLoaded(value)));
 var currList=  await CurrencyRepository().getAllCurrency();
 emit(CurrenciesLoaded(currList));
 print(currList);
  }

  void getRates() async {
    await CurrencyRepository().getAllRates().then((value) {
      emit(RateLoaded(value));
    });
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
