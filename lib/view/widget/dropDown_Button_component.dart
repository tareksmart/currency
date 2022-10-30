import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:currencypro/model/one_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/curency_cubit.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';

class DropDownButtonComponent extends StatefulWidget {
  DropDownButtonComponent(
      {Key? key,
      required this.size,
      required this.allCurrList,
      required this.drop,
      required this.base})
      : super(key: key);
  final Size size;
  final List<CurrencyData>? allCurrList;
  Function(String?, bool) drop;
  final bool base;

  @override
  State<DropDownButtonComponent> createState() =>
      _DropDownButtonComponentState();
}

class _DropDownButtonComponentState extends State<DropDownButtonComponent> {
  OneRate? rate;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CurrencyCubit>(context, listen: false);
    return BlocBuilder<CurrencyCubit, CurrencyState>(builder: (context, state) {
      if (state is OneRateLoaded)
        rate = state.rate;
      
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          items: widget.allCurrList?.map((e) {
            return DropdownMenuItem<String>(
              value: e.currencyCode ?? '',
              child: Row(
                children: [
                  SizedBox(
                    width: widget.size.width * .1,
                    height: widget.size.height * .05,
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
          onChanged: (value) async {
            await bloc.getOneRates(value!);
            print('==============rate list==========');
            print(rate?.rate);

            setState(() {
              widget.drop(rate?.rate, widget.base);
            });
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
