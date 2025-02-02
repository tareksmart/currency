import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

InputDecoration text_form_field_decoration(BuildContext context) {
  return InputDecoration(
    filled: true,
    focusColor: MyColors.greyColor,
    fillColor: MyColors.backGroundTextFieldColor,
    labelStyle: Theme.of(context).textTheme.bodyMedium,
    focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
    enabledBorder:const OutlineInputBorder(borderSide: BorderSide.none),
  );
}
