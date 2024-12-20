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

class DropDownSearchWidgetBaseTest extends StatefulWidget {
  DropDownSearchWidgetBaseTest(
      {super.key,
      required this.basePriceFun,
      required this.currencyDataList,
      required this.size,
      required this.latestRate,
      this.exchangeSelectedItem,
      required this.currBaseDataCallback,
      required this.swap});

  CurrencyData? exchangeSelectedItem;
  final List<CurrencyData> currencyDataList;
  final Size size;
  Function(String) basePriceFun;
  Function(CurrencyData baseCurD) currBaseDataCallback;
  final bool swap;
  // Function(CurrencyData) currBaseDataCallback;
  // Function(CurrencyData) currLocalDataCallback;
  final List latestRate;

  @override
  State<DropDownSearchWidgetBaseTest> createState() => _DropDownSearchWidgetBaseTestState();
}

class _DropDownSearchWidgetBaseTestState extends State<DropDownSearchWidgetBaseTest> {
  CurrencyData? selectedItemBase;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownSearch<CurrencyData>(
        items: widget.currencyDataList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: dropDownSearchDecor(),
        ),
        itemAsString: (item) => item.countryName ?? 'select currency',
        selectedItem: widget.swap ? widget.exchangeSelectedItem : selectedItemBase,
        //لبناء الشكل او العنصر المختار فقط
        dropdownBuilder: (context, selectedItem) {
         if(selectedItem!=null) {
          debugPrint('///////////////${selectedItem.currencyCode}');
            var price = widget.latestRate[0][selectedItem?.currencyCode!];

            widget.basePriceFun(price);
            widget.currBaseDataCallback(selectedItem);
           return SelectedItemWidgetTest(size: widget.size, selectedItem: selectedItem);
         }
         return  Text('select currency');
        },
        onChanged: (value) {
          if (value != null) {
         
            setState(() {
                 selectedItemBase = value;
          
            });
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
