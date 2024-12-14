import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/drop_down_menu_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedItemWidgetTest extends StatelessWidget {
  SelectedItemWidgetTest({super.key, required this.size, required this.selectedItem});

  final Size size;
  final CurrencyData selectedItem;
  @override
  Widget build(BuildContext context) {
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
                selectedItem!.countryName ?? 'select currency',
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
  }
}
