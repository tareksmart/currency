import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/curency_cubit.dart';
import '../../model/currency_data.dart';
import '../../model/currency_rate.dart';
import '../constant/myConstants.dart';

class DropDownButtonComponent extends StatelessWidget {
   DropDownButtonComponent(
      {Key? key, required this.size, required this.allCurrList})
      : super(key: key);
  final Size size;
  final List<CurrencyData>? allCurrList;
  List<CurrencyRate>? rateList;
  @override
  Widget build(BuildContext context) {
final bloc= BlocProvider.of<CurrencyCubit>(context,listen: false);
    return BlocBuilder<CurrencyCubit,CurrencyState>(builder: (context,state){
      if(state is RateLoaded)rateList=state.ratesList;
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          items: allCurrList?.map((e) {
            return DropdownMenuItem<String>(
              value: e.currencyCode ?? '',
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
            bloc.getRates();
            print('==============rate list==========');
             print(rateList);
          },
          isExpanded: true,
          iconEnabledColor: MyColors.ButtonColor,
          iconSize: 30,
          elevation: 1,
        ),
      );

    });


  }
}
