import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/drop_down_search_widget.dart';
import 'package:currencypro/view/widget/selected_item_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDropDownMenuItem extends StatefulWidget {
  MyDropDownMenuItem(
      {super.key,
      required this.currencyDataList,
      required this.size,
      required this.basePriceFun,
      required this.localPriceFun,
      required this.typeOfCurrency,
      required this.latestRate,
      required this.currBaseDataCallback,
      required this.currLocalDataCallback,
      required this.exchange,
      this.baseCurrFromHome,
      this.localCurrFromHome});
  final List<CurrencyData> currencyDataList;
  final Size size;
  // final Map<String, dynamic> allRate;
  final String typeOfCurrency;
  Function(String) basePriceFun;
  Function(String) localPriceFun;
  Function(CurrencyData) currBaseDataCallback;
  Function(CurrencyData) currLocalDataCallback;
  final List latestRate;
  bool exchange;
  CurrencyData? baseCurrFromHome;
  CurrencyData? localCurrFromHome;
  List<CurrencyData> selectedItems = [];
  @override
  State<MyDropDownMenuItem> createState() => _MyDropDownMenuItemState();
}

class _MyDropDownMenuItemState extends State<MyDropDownMenuItem> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.exchange = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  if( widget.exchange == false)
    if (widget.key == const Key('base') ) {
      return DropDownSearchWidget(
        widget: widget,
        exchangeSelectedItem: widget.baseCurrFromHome,
      );
    } else {
      return DropDownSearchWidget(
        widget: widget,
        exchangeSelectedItem: widget.localCurrFromHome,
      );
    }
    return DropDownSearchWidget(widget: widget);
  }
}
