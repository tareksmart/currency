import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';

import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';

import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/services/hive_services.dart';
import 'package:currencypro/view/decoration/text_form_decoration.dart';
import 'package:currencypro/view/widget/drop_down_search_widget_base_test.dart';
import 'package:currencypro/view/widget/drop_down_search_widget_locale_test.dart';
import 'package:currencypro/view/widget/waiting_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constant/myConstants.dart';
import 'convert_button.dart';

class CurrencyCardTab extends StatefulWidget {
  CurrencyCardTab({Key? key, required this.allCurrency, this.allRate})
      : super(key: key);
  final allCurrency, allRate;
  @override
  State<CurrencyCardTab> createState() => _CurrencyCardTabState();
}

class _CurrencyCardTabState extends State<CurrencyCardTab> {
  final _baseCurrency_controller = TextEditingController();

  final _toCurr_controller = TextEditingController();
  String _selectedValue = '0';
  String _basePrice = '0';
  String _toPrice = '0';
  CurrencyData _baseCurrData = CurrencyData();
  CurrencyData _localCurrData = CurrencyData();
  final _globalKey = GlobalKey<FormState>();
  final Key baseKey = const Key('base');
  final Key localeKey = const Key('locale');
  bool exchange = true;
  HiveSevices hiveSevices = HiveSevices();
  List<Map<dynamic, dynamic>> latestRate = [];
  bool swap = false;

  void basePriceCallBack(String baseCurr) {
    _basePrice = baseCurr;
  }

  void localPriceCallBack(String localCurr) {
    _toPrice = localCurr;
  }

  void currBaseDataCallback(CurrencyData baseCurD) {
    _baseCurrData = baseCurD;
    // debugPrint('******currBaseDataCallback ${baseCurD.countryName}');
  }

  void currLocalDataCallback(CurrencyData localCurrD) {
    _localCurrData = localCurrD;
    //debugPrint('******currLocalDataCallback ${localCurrD.countryName}');
  }

  CurrencyData baseCallBackReturn() {
    return _baseCurrData;
  }

  CurrencyData localCallBackReturn() {
    return _localCurrData;
  }

  void _swapValues() {
    setState(() {
      swap = !swap;
      //   final temp = _baseCurrData;
      //   _baseCurrData = _localCurrData;
      //  _localCurrData = temp;
    });
  }

  String result(String basePrice, String toPrice, String mony) {
    double base = double.parse(basePrice);
    double tPrice = double.parse(toPrice);
    double mny = double.parse(mony);
    double result = ((tPrice / base) * mny);

    return result.toStringAsFixed(2); //تقريب الى عددين
  }

  // _callLatestRate() async {
  //   await BlocProvider.of<LatestCurrCubit>(context).getRates();
  // }
  readLatestRate() async {
    latestRate = await hiveSevices.readFromHiveLatestRate();
  }

  @override
  void initState() {
    // TODO: implement initState
    // triggerHiveCubit();
    hiveSevices.readHive(context);
    readLatestRate();
    super.initState();

    // _callLatestRate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _baseCurrency_controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // String x = '0';

    return BlocBuilder<ReadCurrencyCubit, ReadCurrencyState>(
      builder: (context, state) {
        if (state is ReadCurrencysuccessState) {
          return Column(
            //alignment: Alignment.center,
            children: [
              SizedBox(
                height: 270,
                child: Card(
                  elevation: 12,
                  color: Colors.white,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      MyconstantName.amount,
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 16),
                                    ),
                                  ),
                                  DropDownSearchWidgetBaseTest(
                                    currencyDataList: state.currencyList,
                                    basePriceFun: basePriceCallBack,
                                    size: size,
                                    latestRate: latestRate,
                                    currBaseDataCallback: currBaseDataCallback,
                                    exchangeSelectedItem: _localCurrData,
                                    swap: swap,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: BlocConsumer<PressNumberCubit,
                                  PressNumberCubitState>(
                                buildWhen: (previous, current) =>
                                    current is PressedNumber,
                                listener: (context, state) {
                                  if (state is PressedNumber) {
                                    _baseCurrency_controller.text +=
                                        state.number;
                                    if (state.number == '')
                                      _baseCurrency_controller.text = '';
                                    //  _baseCurrency_controller.dispose();
                                  }
                                },
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 16),
                                    child: TextFormField(
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: MyColors.numberColor),
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      controller: _baseCurrency_controller,
                                      decoration:
                                          text_form_field_decoration(context),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          color: MyColors.ButtonColor,
                          iconSize: 42,
                          onPressed: () {
                            _swapValues();
                            _toCurr_controller.text = result(_basePrice,
                                _toPrice, _baseCurrency_controller.text.trim());
                          },
                          icon: const Icon(Icons.currency_exchange_rounded),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      MyconstantName.convertedAmount,
                                      style: TextStyle(
                                          color: Colors.blue[300],
                                          fontSize: 16),
                                    ),
                                  ),
                                  DropDownSearchWidgetLocaleTest(
                                      currencyDataList: state.currencyList,
                                      size: size,
                                      latestRate: latestRate,
                                      localPriceFun: localPriceCallBack,
                                      currLocalDataCallback:
                                          currLocalDataCallback,
                                      swap: swap,
                                      exchangeSelectedItem:
                                          baseCallBackReturn()),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: MyColors.numberColor),
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  controller: _toCurr_controller,
                                  decoration:
                                      text_form_field_decoration(context),
                                ),
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
                              return WaitingAlertDialog(
                                title: 'please wait',
                                progressColor: Colors.green,
                              );
                            } else if (state is AddCurrencyDataSuccess) {
                              hiveSevices.readHive(
                                  context); //read curr when finished adding
                            } else if (state is AddCurrencyDataFailure) {
                              return WaitingAlertDialog(
                                title: 'Fail loading',
                                progressColor: Colors.red,
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
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 5),
                      child: ConvertButton(
                        text: 'CONVERT',
                        onTab: () async {
                          _toCurr_controller.text = result(_basePrice, _toPrice,
                              _baseCurrency_controller.text.trim());
                        },
                        size: size,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is ReadCurrencyWaitingState) {
          return WaitingAlertDialog(title: 'please wait reading data');
        } else {
          return const Column(
            children: [
              Icon(Icons.error),
              Text('no data loaded please check internet connection')
            ],
          );
        }
      },
    );
  }
}
