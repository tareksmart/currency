import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDropDownMenuItem extends StatelessWidget {
  MyDropDownMenuItem(
      {super.key, required this.currencyDataList, required this.size, required this.allRate});
  final List<CurrencyData> currencyDataList;
  final Size size;
  final CurrencyRate allRate;
  @override
  Widget build(BuildContext context) {
    // var latestCubit=BlocProvider.of<LatestCurrCubit>(context);
    return DropdownMenu<String?>(
      label: Text('select currency'),
      width: size.width * .4,
      menuHeight: size.height * .5,
      requestFocusOnTap: true,
      dropdownMenuEntries: currencyDataList.map((e) {
        return DropdownMenuEntry(
            leadingIcon: CachedNetworkImage(
              imageUrl: e.icon!,
              placeholder: (context, url) =>
                  Image.asset('assets/images/Missing_flag.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/Missing_flag.png'),
            ),
            value: e.currencyCode,
            label: e.currencyName ?? 'dollar');
      }).toList(),
      enableSearch: true,
      enableFilter: true,
      onSelected: (value) {
        var fromPrice=allRate.eGP;
        },
    );
  }
  _currPrice(currCode){
    currencyDataList.map((e) {
     if(e.currencyCode==currCode){
      return allRate.currCode;
     }
    });
  }
}
