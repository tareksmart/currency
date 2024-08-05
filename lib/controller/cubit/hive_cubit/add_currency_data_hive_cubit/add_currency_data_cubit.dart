import 'package:bloc/bloc.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

part 'add_currency_data_cubit_state.dart';

class AddCurrencyDataCubit extends Cubit<AddCurrencyDataState> {
  AddCurrencyDataCubit() : super(AddCurrencyDataInitial());

  addCurrencyData(List<CurrencyData> currencyDataList) async {
    try {
      var currBox = Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
      emit(AddCurrencyDataWaitingState());
      for (int i = 0; i < currencyDataList.length; i++) {
        await currBox.add(currencyDataList[i]);
      }
      var addDateBox = Hive.box<String>(MyconstantName.dateAddHiveBox);
      var date = dateFormat(DateTime.now());
      await addDateBox.put(MyconstantName.addDateKeyName,
          date);
      emit(AddCurrencyDataSuccess());
    } catch (e) {
      emit(AddCurrencyDataFailure(errorMessage: e.toString()));
    }
  }

  String dateFormat(DateTime dateTime) {
    var date = dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString();
    return date;
  }
}
