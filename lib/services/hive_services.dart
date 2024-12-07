import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HiveSevices{


  readHive(BuildContext context) async {
    //تم تاخير القراءة من ال
    //hive for 2second
    //لحل مشكلة ان ستايت القراءة بيجى قبل ستايت الكتابة
  //  if (mounted) {
      await Future.delayed(const Duration(milliseconds: 300));
      BlocProvider.of<ReadCurrencyCubit>(context).readCurrency();
    //}
  }

    List<Map<String, dynamic>> latestRate = [];
   readLatestRate() async {
    //var rateBox = await Hive.openBox<Map<String, dynamic>>(MyconstantName.latestRateBox);
    //await Future.delayed(const Duration(seconds: 10));
    //var rateBox = Hive.box(MyconstantName.latestRateBox);
     latestRate = await readFromHive();
     return latestRate;
  }

  Future<List<Map<String, dynamic>>> readFromHive() async {
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
}