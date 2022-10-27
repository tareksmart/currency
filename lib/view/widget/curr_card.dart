import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:currencypro/model/currency_data.dart';
import 'package:currencypro/utilities/asset_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/currency_rate.dart';
import '../constant/myConstants.dart';
import 'dropDown_Button_component.dart';

class Currencycard extends StatefulWidget {
  Currencycard({Key? key}) : super(key: key);

  @override
  State<Currencycard> createState() => _CurrencycardState();
}

class _CurrencycardState extends State<Currencycard> {
  final _baseCurrency_controller = TextEditingController();

  final _toCurr_controller = TextEditingController();
  String _selectedValue='0';
  final _globalKey = GlobalKey<FormState>();
  List<CurrencyData>? allCurrList;


  @override
  void initState() {
    BlocProvider.of<CurrencyCubit>(context,listen: false).getAllCurrData();
    print('trigger=====');
    super.initState();
  }
void dropDownCallBack(String? selectedValue){
if(selectedValue is String){
setState(() {
_selectedValue=selectedValue;
});
}
}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrencyCubit, CurrencyState>(builder: (context, state) {
      if (state is CurrenciesLoaded)
        allCurrList = state.currencisList;
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
                        child: DropDownButtonComponent(size: size,
                          allCurrList: allCurrList,)
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
                        child:DropDownButtonComponent(size: size,
                          allCurrList: allCurrList,)
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
