import 'package:currencypro/utilities/asset_links.dart';
import 'package:flutter/material.dart';

import '../constant/myConstants.dart';

class Currencycard extends StatelessWidget {
  Currencycard({Key? key}) : super(key: key);
  final _baseCurrency_controller = TextEditingController();
  final _toCurr_controller = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .4,
      width: size.width * .9,
      child: Card(
        shadowColor: MyColors.shadowColor,
        color: MyColors.primaryColor,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width*.1,
                                  height: size.height*.05,
                                  child: Image.network(

                                    AppAssets.usaFlag,
                                    fit: BoxFit.fill,

                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'USD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: MyColors.ButtonColor),
                                ),
                              ],
                            ),
                          )
                        ],
                        onChanged: (value) {},
                        isExpanded: true,
                        iconEnabledColor: MyColors.ButtonColor,
                        iconSize: 30,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _baseCurrency_controller,
                        decoration: InputDecoration(

                            labelStyle: Theme.of(context).textTheme.subtitle2),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem(
                              child: Row(
                            children: [
                              SizedBox(
                                width: size.width*.1,
                                height: size.height*.05,
                                child: Image.network(

                                  AppAssets.andiaFlag,
                                  fit: BoxFit.fill,

                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                'INR',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: MyColors.ButtonColor),
                              ),
                            ],
                          ))
                        ],
                        onChanged: (value) {},
                        isExpanded: true,
                        iconEnabledColor: MyColors.ButtonColor,
                        iconSize: 30,
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _toCurr_controller,
                        decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.subtitle2),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
