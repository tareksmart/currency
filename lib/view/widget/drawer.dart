import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import 'card_currency.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.size, required this.allCur})
      : super(key: key);
  final Size size;
  final List<CurrencyData> allCur;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.backGroundTextFieldColor,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .7,
                  height: size.height * .06,
                ),
                const Icon(Icons.close)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width * .8,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black26),
                        hintText: 'Search Country',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * .017,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .6,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.mic_none,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
              ),
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: allCur
                        .map((e) => Card4(
                              Cur: e,
                            ))
                        .toList(),
                  );
                },
                /*  children: [
                  Card4(
                    Cur: allCur[0],
                  )
                ],*/
              ),
            ),
          ],
        ),
      ),
    );
  }
}
