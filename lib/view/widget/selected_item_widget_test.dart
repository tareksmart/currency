import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/not%20used%20widget/drop_down_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedItemWidgetTest extends StatelessWidget {
  SelectedItemWidgetTest(
      {super.key, required this.size, required this.selectedItem});

  final Size size;
  final CurrencyData selectedItem;
  @override
  Widget build(BuildContext context) {
    debugPrint('*******inside selected item++++${selectedItem.countryName}');
    return SizedBox(
      height: size.height * 0.05,
      //  width: size.width * .6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CachedNetworkImage(
                imageUrl: selectedItem.icon!,
                fit: BoxFit.contain,
                width: 42,
                height: 45,
                placeholder: (context, url) =>
                    Image.asset('assets/images/Missing_flag.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/Missing_flag.png'),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                selectedItem!.currencyCode ?? 'select currency',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: MyColors.dropDownSearchfontColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
