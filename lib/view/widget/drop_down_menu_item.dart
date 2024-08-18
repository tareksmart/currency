import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDropDownMenuItem extends StatelessWidget {
  MyDropDownMenuItem(
      {super.key,
      required this.currencyDataList,
      required this.size,
      required this.basePriceFun,
      required this.localPriceFun,
      required this.typeOfCurrency,
      this.latestRate});
  final List<CurrencyData> currencyDataList;
  final Size size;
  // final Map<String, dynamic> allRate;
  final String typeOfCurrency;
  Function(String) basePriceFun;
  Function(String) localPriceFun;
  final latestRate;
  String _selectedItem = "EGP";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .4,
      child: DropdownSearch<CurrencyData>(
        items: currencyDataList,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(gapPadding: 2)),
        ),
        itemAsString: (item) => item.countryName ?? 'select country',
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem != null) {
            return SizedBox(
              height: size.height * .05,
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
                        selectedItem.countryName ?? 'select country',
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
              'select country',
              style: TextStyle(color: MyColors.dropDownSearchfontColor),
            );
        },
        onChanged: (value) {
          //debugPrint(value?.countryCode!);
          print('latest rate is ${latestRate[value?.countryCode!]}for curr code ${value?.countryCode!}');
        },
        popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: true,
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(
                  item.countryName ?? 'knwon',
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
              'search country',
              style: TextStyle(color: Colors.blue, fontSize: 10),
            )),
      ),
    );
//     return DropdownMenu<String?>(
//       label: Text(
//         'select $typeOfCurrency',
//         style: TextStyle(fontSize: 14, color: Colors.blue[700]),
//       ),
//       width: size.width * .4,
//       menuHeight: size.height * .5,
//       dropdownMenuEntries: currencyDataList.map((e) {
//         debugPrint('********************loop');

//         return DropdownMenuEntry(
//             // leadingIcon: CachedNetworkImage(
//             //   imageUrl: e.icon!,
//             //   fit: BoxFit.contain,
//             //   width: 16,
//             //   height: 20,
//             //   placeholder: (context, url) =>
//             //       Image.asset('assets/images/Missing_flag.png'),
//             //   errorWidget: (context, url, error) =>
//             //       Image.asset('assets/images/Missing_flag.png'),
//             // ),
//             value: e.currencyCode,
//             label: e.currencyName ?? 'dollar');
//       }).toList(),
//       requestFocusOnTap: true,
//       enableSearch: true,
//       onSelected: (value) {
//         if (value != null) {
//           print('value is $value');
//           // var price = widget.allRate[value];
// //  print('price is $price');
//           // if (widget.typeOfCurrency == MyconstantName.base)
//           //   widget.basePriceFun(price);
//           // else
//           //   widget.localPriceFun(price);
//         }
//       },
//     );
  }
}
