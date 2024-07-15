import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/model/one_rate.dart';
import 'package:currencypro/view/widget/drop_down_menu_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/all_currency_cubit/curency_cubit.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';

class MyDropDownButtonComponent extends StatelessWidget {
  MyDropDownButtonComponent(
      {Key? key,
      required this.size,
      required this.allCurrList,
      required this.drop,
      required this.base,
      required this.allRate})
      : super(key: key);
  final Size size;
  final List<CurrencyData> allCurrList;
  final CurrencyRate allRate;

  // Function(String?, bool) drop;
  Function(String?, bool) drop;

  final bool base;

  OneRate? rate;

  String? currCode;

  bool type = true;

  List<CurrencyData>? searchedList;

  List<CurrencyData>? searchedCurrency(String searchArg) {
    if (allCurrList.isNotEmpty) if (searchArg.trim() != '' &&
        allCurrList.isNotEmpty) {
      return searchedList = allCurrList.where((currency) {
        String g = currency.countryName ?? '';
        return g.toLowerCase().startsWith(searchArg);
      }).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {


      return MyDropDownMenuItem(currencyDataList: allCurrList,size:size);

  }
}
