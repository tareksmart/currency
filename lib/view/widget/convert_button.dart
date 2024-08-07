import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton(
      {Key? key, required this.onTab, required this.text, required this.size})
      : super(key: key);
  final VoidCallback onTab;
  final String text;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .07,
      width: size.width * .45,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: MyColors.dropDownSearchfontColor),
          onPressed: onTab,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: MyColors.whiteColor),
          )),
    );
  }
}
