import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/not%20used%20widget/drop_down_menu_item.dart';
import 'package:currencypro/view/widget/not%20used%20widget/selected_item_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownSearchWidget extends StatelessWidget {
  DropDownSearchWidget(
      {super.key, required this.widget, this.exchangeSelectedItem});

  final MyDropDownMenuItem widget;
  CurrencyData? exchangeSelectedItem;

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
          if (widget.exchange == true && selectedItem != null) {
            return SelectedItemWidget(
              widget: widget,
              selectedItem: selectedItem,
            );
          } else if (widget.exchange == true && exchangeSelectedItem != null) {
            return SelectedItemWidget(
              widget: widget,
              selectedItem: exchangeSelectedItem!,
            );
          } else {
            return const Text('select currency');
          }
        },
        onChanged: (value) {
          if (value != null) {
            var price = widget.latestRate[0][value?.currencyCode!];
            if (widget.typeOfCurrency == MyconstantName.base) {
              widget.basePriceFun(price);
              widget.currBaseDataCallback(value);
            } else {
              widget.localPriceFun(price);
              widget.currLocalDataCallback(value);
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
