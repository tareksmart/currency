import 'package:bloc/bloc.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'add_currency_data_cubit_state.dart';

class AddCurrencyDataCubit extends Cubit<AddCurrencyDataState> {
  AddCurrencyDataCubit() : super(AddCurrencyDataInitial());

  addCurrencyData(CurrencyData currencyData) async {
    try {
      var currBox = Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
      emit(AddCurrencyDataWaitingState());
      await currBox.add(currencyData);
      emit(AddCurrencyDataSuccess());
    } catch (e) {
      emit(AddCurrencyDataFailure(errorMessage: e.toString()));
    }
  }
}
