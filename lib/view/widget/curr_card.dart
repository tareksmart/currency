import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/utilities/asset_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/myConstants.dart';

class Currencycard extends StatefulWidget {
  Currencycard({Key? key}) : super(key: key);

  @override
  State<Currencycard> createState() => _CurrencycardState();
}

class _CurrencycardState extends State<Currencycard> {
  final _baseCurrency_controller = TextEditingController();

  final _toCurr_controller = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  List<CurrencyData>? allCurrList;
  String selectedValue='0';
  @override
  void initState() {
    BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
    print('trigger=====');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrencyCubit, CurrencyState>(builder: (context, state) {
      if (state is CurrenciesLoaded) allCurrList = state.currencisList;
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: allCurrList?.map((e) {
                              return DropdownMenuItem<String>(
                                value: selectedValue,

                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * .1,
                                      height: size.height * .05,
                                      child: Image.network(
                                        e.icon ?? '',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      e.currencyCode ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(color: MyColors.ButtonColor),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {

                              print(value);
                              print('value selected');
                              setState(() {
                                selectedValue=value!;
                                print('selecte value$selectedValue');

                              });
                            },
                            isExpanded: true,

                            iconEnabledColor: MyColors.ButtonColor,
                            iconSize: 30,
                            elevation: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _baseCurrency_controller,
                          decoration: InputDecoration(
                              labelStyle:
                                  Theme.of(context).textTheme.subtitle2),
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

                              value: 'egp',
                                child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * .1,
                                  height: size.height * .05,
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
                            ),

                            ),
                            DropdownMenuItem(
                              value: 'inr',
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * .1,
                                    height: size.height * .05,
                                    child: Image.network(
                                      AppAssets.andiaFlag,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Egp',
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
                          controller: _toCurr_controller,
                          decoration: InputDecoration(
                              labelStyle:
                                  Theme.of(context).textTheme.subtitle2),
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
    });
  }
}
