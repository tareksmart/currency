import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/model/currency_rate.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDropDownMenuItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // var latestCubit=BlocProvider.of<LatestCurrCubit>(context);

    print('******build');
    return DropdownMenu<String?>(
      label: Text('select $typeOfCurrency'),
      width: size.width * .4,
      menuHeight: size.height * .5,
      requestFocusOnTap: true,
      dropdownMenuEntries: currencyDataList.map((e) {
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
      enableSearch: true,
     
      onSelected: (value) {
        var price = allRate[value];

        if (typeOfCurrency == MyconstantName.base)
         basePriceFun(price);
        else
        localPriceFun(price);
      },
    );
  }
}
