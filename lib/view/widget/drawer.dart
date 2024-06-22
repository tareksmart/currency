import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import 'card_currency.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, required this.size, required this.allCur})
      : super(key: key);
  final Size size;
  final List<CurrencyData> allCur;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<CurrencyData>? searchedList;
String sArg="";
var SearchedCurrList=[];
  TextEditingController _searchController = TextEditingController();

  List<CurrencyData>? searchedCurrency(String searchArg) {
    if(widget.allCur.isNotEmpty)

      if (searchArg.trim() != ''&&widget.allCur.isNotEmpty) {
        return searchedList = widget.allCur.where((currency) {
          String g = currency.countryName ?? '';
          return g.toLowerCase().startsWith(searchArg);
        }).toList();
      }
    return null;

  }

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
                Expanded(
                  child: SizedBox(
                    width: widget.size.width * .7,
                    height: widget.size.height * .06,
                  ),
                ),
                const Icon(Icons.close)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  SizedBox(
                    width: widget.size.width * .8,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black26),
                        hintText: 'Search Country',
                      ),
                      onFieldSubmitted: (val) {
                        sArg=val;
                        SearchedCurrList=searchedCurrency(val)??[];

                      },
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: widget.size.height * .019,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.size.width * .5,
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
            SizedBox(
              height: 500,
              width: 300,
              child: ExpandableTheme(
                data: const ExpandableThemeData(
                  iconColor: Colors.blue,
                  useInkWell: true,
                ),
                child: Builder(
                  builder: (context) {
                    if(SearchedCurrList.length>0) {
                      return ListView.builder(
                      itemCount: SearchedCurrList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: SearchedCurrList
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
                    );
                    }else{
                      return const Center(child: Text('ops no data'),);
                    }
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
