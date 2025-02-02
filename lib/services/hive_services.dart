import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HiveSevices {
  readHive(BuildContext context) async {
    //تم تاخير القراءة من ال
    //hive for 2second
    //لحل مشكلة ان ستايت القراءة بيجى قبل ستايت الكتابة
    //  if (mounted) {
    await Future.delayed(const Duration(milliseconds: 1000));
    BlocProvider.of<ReadCurrencyCubit>(context).readCurrency();
    print('============read currency===============');
    //}
  }

  List<Map<String, dynamic>> latestRate = [];
  // readLatestRate() async {
  //   //var rateBox = await Hive.openBox<Map<String, dynamic>>(MyconstantName.latestRateBox);
  //   //await Future.delayed(const Duration(seconds: 10));
  //   //var rateBox = Hive.box(MyconstantName.latestRateBox);
  //   latestRate = await readFromHiveLatestRate();
  //   return latestRate;
  // }

  Future<List<Map<String, dynamic>>> readFromHiveLatestRate() async {
    try {
      var box = await Hive.openBox<Map<dynamic, dynamic>>(
          MyconstantName.latestRateBox);

      final result = box.toMap().map(
            (k, e) => MapEntry(
              k.toString(),
              Map<String, dynamic>.from(e),
            ),
          );
      //print('hive rate number is **${result.values.toList()[0].length}');
      return result.values.toList();
    } on Exception catch (e) {
      throw ('rate exceptio $e');
    }
  }

  ///
  Future<void> futureList(BuildContext context) async {
    var dateBox = Hive.box<String>(MyconstantName.dateAddHiveBox);
    var currBox = Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
    var rateBox = Hive.box<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);

    var date = dateBox.get(MyconstantName.addDateKeyName);
    var addCubit = BlocProvider.of<AddCurrencyDataCubit>(context);
    var datenow = addCubit.dateFormat(DateTime.now());
    if (date != addCubit.dateFormat(DateTime.now()) ||
        rateBox.length <= 0 ||
        currBox.length <= 0) {
      await currBox.deleteFromDisk();
      await dateBox.deleteFromDisk();
      await rateBox.deleteFromDisk();

      await BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
      await BlocProvider.of<LatestCurrCubit>(context).getRates();
    }
  }

  ///trigger addCurrencyCubit
  void triggerHiveCubit(var allCurrency, BuildContext context) async {
    await BlocProvider.of<AddCurrencyDataCubit>(context)
        .addCurrencyData(allCurrency);
    print('*********triggerHiveCubit');
  }

  saveRate(Map<dynamic, dynamic> ratesMap) async {
    try {
      var latestBox = await Hive.openBox<Map<dynamic, dynamic>>(
          MyconstantName.latestRateBox);

      // Hive.box<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);
      // await Future.delayed(const Duration(seconds: 10));
      await latestBox.put('latestRate', ratesMap);
      print('*****saving rate to hive');
    } catch (e) {
      print('*****saving rate to hive${e.toString()}');
    }
  }
}
