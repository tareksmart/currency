import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/drop_down_menu_item.dart';
import 'package:currencypro/view/widget/selected_item_widget.dart';
import 'package:currencypro/view/widget/selected_item_widget_test.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownSearchWidgetBaseTest extends StatelessWidget {
  DropDownSearchWidgetBaseTest(
      {super.key,
         required this.basePriceFun,
     
      required this.currencyDataList,
      required this.size, required this.latestRate});


  CurrencyData? exchangeSelectedItem;
  final List<CurrencyData> currencyDataList;
  final Size size;
  Function(String) basePriceFun;

  // Function(CurrencyData) currBaseDataCallback;
  // Function(CurrencyData) currLocalDataCallback;
  final List latestRate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .6,
      child: DropdownSearch<CurrencyData>(
        items: currencyDataList,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(gapPadding: 2)),
        ),
        itemAsString: (item) => item.countryName ?? 'select currency',
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem != null) {
            return SelectedItemWidgetTest(
              size: size,
              selectedItem: selectedItem,
            );
          } else {
            return const Text('select currency');
          }
        },
        onChanged: (value) {
          if (value != null) {
            var price =latestRate[0][value?.currencyCode!];

            basePriceFun(price);
            //widget.currBaseDataCallback(value);
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
