import 'package:bloc/bloc.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'read_currency_state.dart';

class ReadCurrencyCubit extends Cubit<ReadCurrencyState> {
  ReadCurrencyCubit() : super(ReadCurrencyInitial());

  readCurrency() async {
    try {
      var box = Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
      emit(ReadCurrencyWaitingState());
      
     // if(currdata.length>5) {
       List<CurrencyData> currdata = box.values.toList();
      
      
        emit(ReadCurrencysuccessState(currencyList: currdata));
     // }
      
    } catch (e) {
      emit(ReadCurrencyfailureState(errorMessage: e.toString()));
    }
  }
}
