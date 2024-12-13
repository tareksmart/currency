import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
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
  late CurrencyData _baseCur = CurrencyData();
  late CurrencyData _localCur = CurrencyData();
  @override
  void dispose() {
    // TODO: implement dispose
    widget.exchange = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * .4,
      child: DropdownSearch<CurrencyData>(
        items: widget.currencyDataList,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(gapPadding: 2)),
        ),
        itemAsString: (item) => item.countryName ?? 'select currency',
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem != null) {
            if (widget.exchange) {
              return SelectedItemWidget(
                widget: widget,
                selectedItem: selectedItem,
              );
            } else {
              if (widget.baseCurrFromHome!.countryCode!.isNotEmpty) {
                widget.exchange=true;
                return SelectedItemWidget(
                  widget: widget,
                  selectedItem: widget.baseCurrFromHome,
                );
             
              }
              if (widget.localCurrFromHome!.countryCode!.isNotEmpty) {
                widget.exchange=true;
                return SelectedItemWidget(
                  widget: widget,
                  selectedItem: widget.localCurrFromHome,
                );
              }
                return Text(
              'select currency',
              style: TextStyle(color: MyColors.dropDownSearchfontColor),
            );
            
            }
         
          } else {
            return Text(
              'select currency',
              style: TextStyle(color: MyColors.dropDownSearchfontColor),
            );
          }
        
        },
        onChanged: (value) {
          if (value != null) {
            var price = widget.latestRate[0][value?.currencyCode!];
            if (widget.typeOfCurrency == MyconstantName.base) {
              widget.basePriceFun(price);
              widget.currBaseDataCallback(value);
              _baseCur = value;
            } else {
              widget.localPriceFun(price);
              widget.currLocalDataCallback(value);
              _localCur = value;
            }
          }
        },
        popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: true,
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(
                  item.currencyName ?? 'knwon',
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CachedNetworkImage(
                  imageUrl: item.icon!,
                  fit: BoxFit.contain,
                  width: 30,
                  height: 30,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/Missing_flag.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/Missing_flag.png'),
                ),
              );
            },
            title: const Text(
              'search currency',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            )),
      ),
    );
  }
}
