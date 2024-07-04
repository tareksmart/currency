import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropDownMenuItem extends StatelessWidget {
  MyDropDownMenuItem({super.key, required this.currencyDataList, required this.size});
  final List<CurrencyData> currencyDataList;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: Text('select currency'),
      width: size.width*.5,
      menuHeight: size.height*.5,
      requestFocusOnTap: true,
      dropdownMenuEntries:  currencyDataList.map((e) {
        return DropdownMenuEntry(
          leadingIcon:CachedNetworkImage(imageUrl: e.icon!,
            placeholder: (context, url) =>
                Image.asset('assets/images/Missing_flag.png'),
            errorWidget: (context, url, error) => Image.asset('assets/images/Missing_flag.png') ,) ,
            value: e.currencyCode, label: e.currencyName ?? 'dollar');
      }).toList(),
      enableSearch: true,
      enableFilter: true,

    );
  }
}
