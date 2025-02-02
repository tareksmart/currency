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
   //   if(Hive.box(MyconstantName.currencyDataBox).isOpen==false)
      await Hive.openBox<CurrencyData>(MyconstantName.currencyDataBox);
     // if(Hive.box(MyconstantName.dateAddHiveBox).isOpen!=true)
  await Hive.openBox<String>(MyconstantName.dateAddHiveBox);
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
///get date of day
  String dateFormat(DateTime dateTime) {
    var date = dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString();
    return date;
  }
}
