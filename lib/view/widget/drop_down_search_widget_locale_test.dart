import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/decoration/drop_down_search_decor.dart';
import 'package:currencypro/view/widget/not%20used%20widget/drop_down_menu_item.dart';
import 'package:currencypro/view/widget/not%20used%20widget/selected_item_widget.dart';
import 'package:currencypro/view/widget/selected_item_widget_test.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownSearchWidgetLocaleTest extends StatelessWidget {
  DropDownSearchWidgetLocaleTest(
      {super.key,
      required this.currencyDataList,
      required this.size,
      required this.latestRate,
      required this.localPriceFun,
      required this.currLocalDataCallback,
      this.exchangeSelectedItem,
      required this.swap});

  final List<CurrencyData> currencyDataList;
  final Size size;
  CurrencyData? exchangeSelectedItem;
  Function(String) localPriceFun;
  // Function(CurrencyData) currBaseDataCallback;
  Function(CurrencyData) currLocalDataCallback;
  final List latestRate;
  final bool swap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .4,
      child: DropdownSearch<CurrencyData>(
        items: currencyDataList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: dropDownSearchDecor(),
        ),
        itemAsString: (item) => item.countryName ?? 'select currency',
        dropdownBuilder: (context, selectedItem) {
          if (selectedItem != null) {
            currLocalDataCallback(selectedItem);
            return SelectedItemWidgetTest(
              size: size,
              selectedItem: selectedItem,
            );
          } else if (swap == true) {
               selectedItem = null;
            return SelectedItemWidgetTest(
              size: size,
              selectedItem: exchangeSelectedItem!,
            );
          } else {
            return Text('select currency');
          }
        },
        onChanged: (value) {
          if (value != null) {
            var price = latestRate[0][value?.currencyCode!];

            localPriceFun(price);
            // widget.currBaseDataCallback(value);
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
