import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../model/currency_data.dart';

class Card4 extends StatelessWidget {
  const Card4({super.key, required this.Cur});

  final CurrencyData Cur;
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    // buildList() {
    //   return Column(
    //     children: <Widget>[
    //       for (var i in [1, 2, 3, 4]) buildItem("Item ${i}"),
    //     ],
    //   );
    // }
    buildList() {
      return
             Column(children: [
              Text('${Cur.currencyName}'),
              Text('${Cur.currencyCode}'),
              Text('${Cur.countryName}'),

            ]);

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
                                height:50,
                                width: 50,
                                child: Image.network(
                                  Cur.icon ?? '',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "${Cur.countryName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: SizedBox(height: 200, child: buildList()),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
