import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/currency_states.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/currency_data.dart';

class Card4 extends StatelessWidget {
  const Card4({super.key, required this.Cur});

  final CurrencyData Cur;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CurrencyCubit>(context, listen: false);
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    String price(String curr) {
      if (curr.trim() != '') {
        bloc.getOneRates(curr);
        return bloc.price;
      } else
        return '0';
    }

    // buildList() {
    //   return Column(
    //     children: <Widget>[
    //       for (var i in [1, 2, 3, 4]) buildItem("Item ${i}"),
    //     ],
    //   );
    // }
    buildList() {
      return Center(
        child: Column(children: [
          Text('Cur.Name: ${Cur.currencyName}'),
          Text('Cur.Country: ${Cur.countryName}'),
          /*Text(price(Cur.currencyCode ?? '')),*/
        ]),
      );
    }

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Container(
                  color: Colors.indigoAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: Icons.arrow_right,
                            collapseIcon: Icons.arrow_drop_down,
                            iconColor: Colors.white,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                      imageUrl: Cur.icon ?? '',
                      placeholder: (context, url) =>
                          Image.asset('assets/images/Missing_flag.png'),
                          errorWidget: (context, url, error) => Image.asset('assets/images/Missing_flag.png') ,
                    )),
                              Expanded(
                                child: Text(
                                  Cur.countryName ?? 'unknown',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: SizedBox(height: 50, child: buildList()),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
