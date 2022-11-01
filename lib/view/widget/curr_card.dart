import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constant/myConstants.dart';
import 'convert_button.dart';
import 'dropDown_Button_component.dart';

class Currencycard extends StatefulWidget {
  Currencycard({Key? key}) : super(key: key);

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
  List<CurrencyData>? allCurrList;

  @override
  void initState() {
    BlocProvider.of<CurrencyCubit>(context, listen: false).getAllCurrData();
    print('trigger=====');
    super.initState();
  }

  // void dropDownCallBack(String? selectedValue, bool base) {
  //   if (selectedValue is String) {
  //     _selectedValue = selectedValue;
  //     if (base == true) {
  //       _basePrice = selectedValue;
  //       _baseCurrency_controller.text = selectedValue;
  //     } else {
  //       _toPrice = selectedValue;
  //       _toCurr_controller.text = selectedValue;
  //     }
  //     setState(() {});
  //   }
  // }
  void dropDownCallBack(String? selectedValue) {

    if (selectedValue is String) {
      _basePrice = selectedValue;

      //setState(() {});
    }
  }

  void dropDownCallBackToPrice(String? selectedValue) {
    if (selectedValue is String) {
      _toPrice = selectedValue;
    }
  }

  String result(String basePrice, String toPrice, String mony) {
    double base = double.parse(basePrice);
    double tPrice = double.parse(toPrice);
    int mny = int.parse(mony);
    double result = (tPrice / base) * mny;
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrencyCubit, CurrencyState>(builder: (context, state) {
      if (state is CurrenciesLoaded) allCurrList = state.currencisList;
      return Stack(
        children: [
          SizedBox(
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
                            child: DropDownButtonComponent(
                              base: true,
                              drop: dropDownCallBack,
                              size: size,
                              allCurrList: allCurrList, dropToPrice: (val ) {  },
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                value = _selectedValue;
                                //   _baseCurrency_controller.text = _selectedValue;
                                setState(() {});
                                print('inside form field/////////////');
                                print(_selectedValue);
                                print('inside form field/////////////');
                              },
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
                              child: DropDownButtonComponent(
                            base: false,
                            dropToPrice: dropDownCallBackToPrice,
                            size: size,
                            allCurrList: allCurrList,
                            drop: (val) {},
                          )),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _toCurr_controller,
                              onChanged: (value) {
                                value = _selectedValue;
                                setState(() {});
                              },
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
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * .37,
              ),
              Align(
                alignment: Alignment.center,
                child: ConvertButton(
                  text: 'CONVERT',
                  onTab: () {
                    print('base $_basePrice');
                    print('_toPrice $_toPrice');
                    print(
                        '_baseCurrency_controller.text $_baseCurrency_controller.text');
                    _toCurr_controller.text = result(_basePrice, _toPrice,
                        _baseCurrency_controller.text.trim());
                  },
                  size: size,
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
