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
      required this.typeOfCurrency,
      required this.currBaseDataCallback,
      required this.currLocalDataCallback,
      required this.exchange,this.baseCurrFromHome,this.localCurrFromHome})
      : super(key: key);
  final Size size;
  // final Map<String, dynamic> allRate;
  // Function(String?, bool) drop;
  Function(String) basePriceFunc;
  Function(String) localPriceFunc;
  Function(CurrencyData) currBaseDataCallback;
  Function(CurrencyData) currLocalDataCallback;
  final bool base;
  final String typeOfCurrency;
  final bool exchange;
  CurrencyData? baseCurrFromHome;
  CurrencyData? localCurrFromHome;


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
    readLatestRate();
    
  }

  readHive() async {
    //تم تاخير القراءة من ال
    //hive for 2second
    //لحل مشكلة ان ستايت القراءة بيجى قبل ستايت الكتابة
    await Future.delayed(const Duration(seconds: 10));
    BlocProvider.of<ReadCurrencyCubit>(context).readCurrency();
  }

  void readLatestRate() async {
    //var rateBox = await Hive.openBox<Map<String, dynamic>>(MyconstantName.latestRateBox);
    //await Future.delayed(const Duration(seconds: 10));
    //var rateBox = Hive.box(MyconstantName.latestRateBox);

    latestRate = await readFromHive();
  }

  Future<List<Map<String, dynamic>>> readFromHive() async {
    final box =
        await Hive.openBox<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);

    final result = box.toMap().map(
          (k, e) => MapEntry(
            k.toString(),
            Map<String, dynamic>.from(e),
          ),
        );
    //print('hive rate number is **${result.values.toList()[0].length}');
    return result.values.toList() ?? [];
  }

  // List<CurrencyData>? searchedCurrency(String searchArg) {
  @override
  Widget build(BuildContext context) {
     
    return BlocBuilder<ReadCurrencyCubit, ReadCurrencyState>(
      buildWhen: (previous, current) => current is ReadCurrencysuccessState,
      builder: (context, state) {
        if (state is ReadCurrencysuccessState) {
          //debugPrint('*************hive number${state.currencyList.length}');
          return MyDropDownMenuItem(key: widget.key,
            currencyDataList: state.currencyList,
            size: widget.size,
            basePriceFun: widget.basePriceFunc,
            localPriceFun: widget.localPriceFunc,
            typeOfCurrency: widget.typeOfCurrency,
            latestRate: latestRate,
            currBaseDataCallback: widget.currBaseDataCallback,
            currLocalDataCallback: widget.currLocalDataCallback,
            exchange: widget.exchange,
            baseCurrFromHome:widget.baseCurrFromHome,
            localCurrFromHome: widget.localCurrFromHome,
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
