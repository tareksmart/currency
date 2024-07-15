import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/myConstants.dart';
import 'convert_button.dart';
import 'dropDown_Button_component.dart';

class Currencycard extends StatefulWidget {
  Currencycard({Key? key, required this.allCurrency}) : super(key: key);
  var allCurrency;
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

  void dropDownCallBack(String? selectedValue, bool base) {
    if (selectedValue is String) {
      _selectedValue = selectedValue;
      if (base == true) {
        _basePrice = selectedValue;
        //_baseCurrency_controller.text = selectedValue;
      } else {
        _toPrice = selectedValue;
        //_toCurr_controller.text = selectedValue;
      }
      //  setState(() {});
    }
  }

  String result(String basePrice, String toPrice, String mony) {
    double base = double.parse(basePrice);
    double tPrice = double.parse(toPrice);
    double mny = double.parse(mony);
    double result = (tPrice / base) * mny;
    return result.toString();
  }

  _callLatestRate() async {
    await BlocProvider.of<LatestCurrCubitCubit>(context).getRates();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callLatestRate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String x = '0';

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size.height * .35,
          width: size.width * .9,
          child: Card(
            shadowColor: MyColors.shadowColor,
            color: MyColors.primaryColor,
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                child: BlocBuilder<LatestCurrCubitCubit, LatestCurrCubitState>(
                  buildWhen: (previous, current) => current is LatestRateSuccessLoaded,
                  builder: (context, state) {
                    if(state is  LatestRateSuccessLoaded) {
                      return Column(
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
                                                  drop: dropDownCallBack,
                                                  size: size,
                                                  allCurrList: widget.allCurrency,
                                                  allRate: state.ratesList,
                                                ),
                                              ),
                                          
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: BlocBuilder<CurrencyCubit, CurrencyState>(
                                              builder: (context, state) {
                                            if (state is PressedNumber) {
                                              if (state.number != '') {
                                                _baseCurrency_controller.text += state.number;
                                              } else
                                                _baseCurrency_controller.text = '';
                                            }
                                            return TextFormField(
                                              readOnly: true,
                                              keyboardType: TextInputType.number,
                                              controller: _baseCurrency_controller,
                                              decoration: InputDecoration(
                                                  labelStyle:
                                                      Theme.of(context).textTheme.subtitle2),
                                            );
                                          }),
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
                                                allCurrList: widget.allCurrency,
                                                allRate: state.ratesList,
                                                drop: dropDownCallBack)),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            readOnly: true,
                                            controller: _toCurr_controller,
                                            onChanged: (value) {
                                              value = _selectedValue;
                                              // setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                labelStyle:
                                                    Theme.of(context).textTheme.subtitle2),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                    }
                    return Text('oops no data loadeed');
                  },
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
                onTab: () {
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
