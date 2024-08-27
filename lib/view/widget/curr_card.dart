import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../constant/myConstants.dart';
import 'convert_button.dart';
import 'dropDown_Button_component.dart';

class Currencycard extends StatefulWidget {
  Currencycard({Key? key, required this.allCurrency, this.allRate})
      : super(key: key);
  final allCurrency, allRate;
  @override
  State<Currencycard> createState() => _CurrencycardState();
}

class _CurrencycardState extends State<Currencycard> {
  final _baseCurrency_controller = TextEditingController();

  final _toCurr_controller = TextEditingController();
  String _selectedValue = '0';
  String _basePrice = '0';
  String _toPrice = '0';
  final _globalKey = GlobalKey<FormState>();

  void basePriceCallBack(String baseCurr) {
    _basePrice = baseCurr;
  }

  void localPriceCallBack(String localCurr) {
    _toPrice = localCurr;
  }

  String result(String basePrice, String toPrice, String mony) {
    double base = double.parse(basePrice);
    double tPrice = double.parse(toPrice);
    double mny = double.parse(mony);
    double result = (tPrice / base) * mny;
    return result.toString();
  }

  // _callLatestRate() async {
  //   await BlocProvider.of<LatestCurrCubit>(context).getRates();
  // }

  @override
  void initState() {
    // TODO: implement initState
    // triggerHiveCubit();
    super.initState();

    // _callLatestRate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // String x = '0';

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size.height * .35,
          width: size.width * .9,
          child: Card(
            elevation: 12,
            color: MyColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyDropDownButtonComponent(
                            key: const ValueKey(1),
                            base: true,
                            basePriceFunc: basePriceCallBack,
                            localPriceFunc: localPriceCallBack,
                            size: size,
                            typeOfCurrency: MyconstantName.base,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: BlocConsumer<PressNumberCubit,
                              PressNumberCubitState>(
                            buildWhen: (previous, current) =>
                                current is PressedNumber,
                            listener: (context, state) {
                              if (state is PressedNumber) {
                                _baseCurrency_controller.text += state.number;
                                if (state.number == '')
                                  _baseCurrency_controller.text = '';
                                //  _baseCurrency_controller.dispose();
                              }
                            },
                            builder: (context, state) {
                              return TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                controller: _baseCurrency_controller,
                                decoration: InputDecoration(
                                    labelStyle:
                                        Theme.of(context).textTheme.subtitle2),
                              );
                            },
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
                            child: MyDropDownButtonComponent(
                          key: const ValueKey(2),
                          base: false,
                          size: size,
                          basePriceFunc: basePriceCallBack,
                          localPriceFunc: localPriceCallBack,
                          typeOfCurrency: MyconstantName.local,
                        )),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            controller: _toCurr_controller,
                            // onChanged: (value) {
                            //   value = _selectedValue;
                            //   // setState(() {});
                            // },
                            decoration: InputDecoration(
                                labelStyle:
                                    Theme.of(context).textTheme.subtitle2),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<AddCurrencyDataCubit, AddCurrencyDataState>(
                      builder: (context, state) {
                        if (state is AddCurrencyDataWaitingState) {
                          return const LinearProgressIndicator(
                            color: Colors.green,
                          );
                        } else if (state is AddCurrencyDataSuccess) {
                        } else if (state is AddCurrencyDataFailure) {
                          return const LinearProgressIndicator(
                            color: Colors.red,
                          );
                        }
                        return const Text('');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .37,
              ),
              ConvertButton(
                text: 'CONVERT',
                onTab: () async {
                  // var currBox =
                  //     Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
                  // var dateBox = Hive.box<String>(MyconstantName.dateAddHiveBox);
                  // await currBox.deleteFromDisk();

                  // await dateBox.deleteFromDisk();
                  // var rateBox = Hive.box<Map<dynamic, dynamic>>(
                  //     MyconstantName.latestRateBox);

                  // await rateBox.deleteFromDisk();
                  print(
                      'result($_basePrice, $_toPrice, ${_baseCurrency_controller.text.trim()});');
                  _toCurr_controller.text = result(_basePrice, _toPrice,
                      _baseCurrency_controller.text.trim());
                },
                size: size,
              ),
            ],
          ),
        )
      ],
    );
  }
}
