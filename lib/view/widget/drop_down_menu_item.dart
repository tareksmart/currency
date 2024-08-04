import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDropDownMenuItem extends StatefulWidget {
  MyDropDownMenuItem(
      {super.key,
      required this.currencyDataList,
      required this.size,
      required this.allRate,
      required this.basePriceFun,
      required this.localPriceFun,
      required this.typeOfCurrency});
  final List<CurrencyData> currencyDataList;
  final Size size;
  final Map<String, dynamic> allRate;
  final String typeOfCurrency;
  Function(String) basePriceFun;
  Function(String) localPriceFun;

  @override
  State<MyDropDownMenuItem> createState() => _MyDropDownMenuItemState();
}

class _MyDropDownMenuItemState extends State<MyDropDownMenuItem> {
  String _selectedItem = "EGP";
  @override
  Widget build(BuildContext context) {
    // var latestCubit=BlocProvider.of<LatestCurrCubit>(context);

    return DropdownMenu<String?>(
      label: Text(
        'select ${widget.typeOfCurrency}',
        style: TextStyle(fontSize: 14, color: Colors.blue[700]),
      ),
      width: widget.size.width * .4,
      menuHeight: widget.size.height * .5,
      dropdownMenuEntries: widget.currencyDataList.map((e) {
        return DropdownMenuEntry(
            leadingIcon: CachedNetworkImage(
              imageUrl: e.icon!,
              fit: BoxFit.contain,
              width: 16,
              height: 20,
              placeholder: (context, url) =>
                  Image.asset('assets/images/Missing_flag.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/Missing_flag.png'),
            ),
            value: e.currencyCode,
            label: e.currencyName ?? 'dollar');
      }).toList(),
      requestFocusOnTap: true,
      enableSearch: true,
      onSelected: (value) {
        if (value != null) {
          print('value is $value');
          var price = widget.allRate[value];
 print('price is $price');
          if (widget.typeOfCurrency == MyconstantName.base)
            widget.basePriceFun(price);
          else
            widget.localPriceFun(price);
        }
      },
    );
  }
}
