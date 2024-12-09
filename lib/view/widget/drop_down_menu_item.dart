import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
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
      required this.exchange});
  final List<CurrencyData> currencyDataList;
  final Size size;
  // final Map<String, dynamic> allRate;
  final String typeOfCurrency;
  Function(String) basePriceFun;
  Function(String) localPriceFun;
  Function(CurrencyData) currBaseDataCallback;
  Function(CurrencyData) currLocalDataCallback;
  final List latestRate;
  final bool exchange;
  List<CurrencyData> selectedItems = [];
  @override
  State<MyDropDownMenuItem> createState() => _MyDropDownMenuItemState();
}

class _MyDropDownMenuItemState extends State<MyDropDownMenuItem> {
  late CurrencyData _baseCur;
  late CurrencyData _localCur;

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
        // onBeforeChange: (prevItem, nextItem) async {
        //   if (prevItem != null)
        //     debugPrint('pre item***********${prevItem!.countryName}');
        //   if (nextItem != null) {
        //     debugPrint('nextItem***********${nextItem!.countryName}');
        //     debugPrint('pre item***********${prevItem!.countryName}');
        //   }
        //   return true;
        // },
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem != null) {
            return SizedBox(
              height: widget.size.height * .05,
              //  width: size.width * .6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CachedNetworkImage(
                      imageUrl: selectedItem.icon!,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                      placeholder: (context, url) =>
                          Image.asset('assets/images/Missing_flag.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/Missing_flag.png'),
                    ),
                    Flexible(
                      child: Text(
                        selectedItem.countryName ?? 'select currency',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: MyColors.dropDownSearchfontColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return Text(
              'select currency',
              style: TextStyle(color: MyColors.dropDownSearchfontColor),
            );
        },
        onChanged: (value) {
          if (value != null) {
            widget.selectedItems.add(value);
            debugPrint(
                '********selectedItems   ${widget.selectedItems.length}');
            if (widget.selectedItems.length > 2) {
              debugPrint(
                  '********selectedItems   ${widget.selectedItems[0].countryName}');
              debugPrint(
                  '********selectedItems   ${widget.selectedItems[1].countryName}');
            }

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
              if(widget.exchange) {
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
              }else{
                  return ListTile(
                title: Text(
                  _localCur.currencyName ?? 'knwon',
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CachedNetworkImage(
                  imageUrl: _localCur.icon!,
                  fit: BoxFit.contain,
                  width: 30,
                  height: 30,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/Missing_flag.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/Missing_flag.png'),
                ),
              );
              }
            },
            title: const Text(
              'search currency',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            )),
      ),
    );
  }
}
