import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/services/hive_services.dart';
import 'package:currencypro/view/widget/drop_down_search_widget_base_test.dart';
import 'package:currencypro/view/widget/drop_down_search_widget_locale_test.dart';
import 'package:currencypro/view/widget/waiting_alert_dialog.dart';
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
  CurrencyData _baseCurrData = CurrencyData();
  CurrencyData _localCurrData = CurrencyData();
  final _globalKey = GlobalKey<FormState>();
  final Key baseKey = const Key('base');
  final Key localeKey = const Key('locale');
  bool exchange = true;
  HiveSevices hiveSevices = HiveSevices();
  List<Map<dynamic, dynamic>> latestRate = [];
  bool _showFirstWidget = true;
  void basePriceCallBack(String baseCurr) {
    _basePrice = baseCurr;
  }

  void localPriceCallBack(String localCurr) {
    _toPrice = localCurr;
  }

  currBaseDataCallback(CurrencyData baseCurD) {
    _baseCurrData = baseCurD;
    debugPrint('******currBaseDataCallback ${baseCurD.countryName}');
  }

  currLocalDataCallback(CurrencyData localCurrD) {
    _localCurrData = localCurrD;
    debugPrint('******currLocalDataCallback ${localCurrD.countryName}');
  }

  void _swapValues() {
    setState(() {
      var temp = _baseCurrData;
      _baseCurrData = _localCurrData;
      _localCurrData = temp;
    });
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
  readLatestRate() async {
    latestRate = await hiveSevices.readLatestRate();
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
                          AnimatedCrossFade(
                              firstChild: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropDownSearchWidgetBaseTest(
                                      currencyDataList: state.currencyList,
                                      basePriceFun: basePriceCallBack,
                                      size: size,
                                      latestRate: latestRate,
                                    ),
                                    // child: MyDropDownButtonComponent(
                                    //   key: baseKey,
                                    //   base: true,
                                    //   basePriceFunc: basePriceCallBack,
                                    //   localPriceFunc: localPriceCallBack,
                                    //   size: size,
                                    //   typeOfCurrency: MyconstantName.base,
                                    //   currBaseDataCallback: currBaseDataCallback,
                                    //   currLocalDataCallback: currLocalDataCallback,
                                    //   exchange: exchange,
                                    //   baseCurrFromHome: _localCurrData,
                                    //   localCurrFromHome: _baseCurrData,
                                    // ),
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
                                          _baseCurrency_controller.text +=
                                              state.number;
                                          if (state.number == '')
                                            _baseCurrency_controller.text = '';
                                          //  _baseCurrency_controller.dispose();
                                        }
                                      },
                                      builder: (context, state) {
                                        return TextFormField(
                                          style: TextStyle(
                                              height: size.height * .003,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          readOnly: true,
                                          keyboardType: TextInputType.number,
                                          controller: _baseCurrency_controller,
                                          decoration: InputDecoration(
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              secondChild: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropDownSearchWidgetLocaleTest(
                                        currencyDataList: state.currencyList,
                                        size: size,
                                        latestRate: latestRate,
                                        localPriceFun: localPriceCallBack),
                                    // child: MyDropDownButtonComponent(
                                    //   key: localeKey,
                                    //   base: false,
                                    //   size: size,
                                    //   basePriceFunc: basePriceCallBack,
                                    //   localPriceFunc: localPriceCallBack,
                                    //   typeOfCurrency: MyconstantName.local,
                                    //   currBaseDataCallback: currBaseDataCallback,
                                    //   currLocalDataCallback: currLocalDataCallback,
                                    //   exchange: exchange,
                                    //   baseCurrFromHome: _localCurrData,
                                    //   localCurrFromHome: _baseCurrData,
                                    // ),
                                  ),
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
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ),
                                  )
                                ],
                              ),
                              crossFadeState: _showFirstWidget
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(seconds: 2)),
                          const SizedBox(
                            height: 12,
                          ),
                          BlocBuilder<AddCurrencyDataCubit,
                              AddCurrencyDataState>(
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
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .37,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showFirstWidget = !_showFirstWidget;
                        });
                      },
                      label: Text('exchange'),
                      icon: Icon(Icons.currency_exchange_rounded),
                    ),
                    ConvertButton(
                      text: 'CONVERT',
                      onTab: () async {
                        _toCurr_controller.text = result(_basePrice, _toPrice,
                            _baseCurrency_controller.text.trim());
                        setState(() {
                          _showFirstWidget = !_showFirstWidget;
                        });
                      },
                      size: size,
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return WaitingAlertDialog(title: 'please wait reading data');
        }
      },
    );
  }
}
