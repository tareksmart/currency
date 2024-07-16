import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/currency_repository.dart';
import 'currency_states.dart';
import 'package:currencypro/model/currency_data.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit() : super(CurrencyIntial());

  getAllCurrData() async {
    emit(CurrencyWaitingState());
    var currList = await CurrencyRepository().getAllCurrency();
    currList.fold(
        (failur) => emit(FailurLoaded(errorMessage: failur.errorMessage)),
        (currencies) => emit(CurrenciesLoaded(currencies)));
    //print(currList);
  }

  // String price = '0';
  // Future<void> getOneRates(String symbole) async {
  //   await CurrencyRepository().getOneRates(symbole).then((value) {
  //     emit(OneRateLoaded(value));
  //     price = value.rate!;
  //   });
  // }

 
}
