import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';
import 'package:currencypro/view/widget/drop_down_menu_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../controller/cubit/all_currency_cubit/curency_cubit.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';

class MyDropDownButtonComponent extends StatefulWidget {
  MyDropDownButtonComponent(
      {Key? key,
      required this.size,
      required this.basePriceFunc,
      required this.localPriceFunc,
      required this.base,
      required this.typeOfCurrency})
      : super(key: key);
  final Size size;
  // final Map<String, dynamic> allRate;
  // Function(String?, bool) drop;
  Function(String) basePriceFunc;
  Function(String) localPriceFunc;
  final bool base;
  final String typeOfCurrency;

  @override
  State<MyDropDownButtonComponent> createState() =>
      _MyDropDownButtonComponentState();
}

class _MyDropDownButtonComponentState extends State<MyDropDownButtonComponent> {
  OneRate? rate;
  String? currCode;
  bool type = true;
  List<CurrencyData>? searchedList;
  var latestRate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readHive();
    latestRate = readLatestRate();
  }

  readHive() async {
    //تم تاخير القراءة من ال
    //hive for 2second
    //لحل مشكلة ان ستايت القراءة بيجى قبل ستايت الكتابة
    await Future.delayed(const Duration(seconds: 10));
    BlocProvider.of<ReadCurrencyCubit>(context).readCurrency();
  }

  readLatestRate() async {
    await Hive.openBox<Map<String, dynamic>>(MyconstantName.latestRateBox);
    await Future.delayed(const Duration(seconds: 10));
    var rateBox = Hive.box<Map<String, dynamic>>(MyconstantName.latestRateBox);
   
    Map<String, dynamic> rates =
        Map<String, dynamic>.from(rateBox.values.first);
         print('*** latest rate number $rates');
    // convertMap(rateBox.get('latesRate')!.entries.first);
    // return rates;
  }

  Map<String, dynamic> convertMap(Map<dynamic, dynamic> inputMap) {
    Map<String, dynamic> outputMap = {};
    inputMap.forEach((key, value) {
      if (key is String) {
        outputMap[key] = value;
      } else {
        // Handle non-string keys here, e.g., throw an exception, log a warning, or ignore
        print('Warning: Non-string key encountered: $key');
      }
    });

    return outputMap;
  }

  // List<CurrencyData>? searchedCurrency(String searchArg) {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCurrencyCubit, ReadCurrencyState>(
      buildWhen: (previous, current) => current is ReadCurrencysuccessState,
      builder: (context, state) {
        if (state is ReadCurrencysuccessState) {
          debugPrint('*************hive number${state.currencyList.length}');
          return MyDropDownMenuItem(
            currencyDataList: state.currencyList,
            size: widget.size,
            basePriceFun: widget.basePriceFunc,
            localPriceFun: widget.localPriceFunc,
            typeOfCurrency: widget.typeOfCurrency,
            latestRate: latestRate,
          );
        } else if (state is ReadCurrencyfailureState) {
          return Text('error:${state.errorMessage}');
        } else if (state is ReadCurrencyWaitingState) {
          return const LinearProgressIndicator();
        } else {
          return const LinearProgressIndicator();
        }
      },
    );
  }
}
