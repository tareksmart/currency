import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import 'currency_list_drawer.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, required this.size}) : super(key: key);
  final Size size;
  // final List<CurrencyData> allCur;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<CurrencyData>? searchedList;
  String sArg = "";
  var SearchedCurrList = [];
  TextEditingController _searchController = TextEditingController();

  List<CurrencyData>? searchedCurrency(
      String searchArg, List<CurrencyData> currList) {
    if (currList.isNotEmpty) {
      if (searchArg.trim() != '' && currList.isNotEmpty) {
        return searchedList = currList.where((currency) {
          String g = currency.countryName ?? '';
          return g.toLowerCase().startsWith(searchArg);
        }).toList();
      } else {
        currList;
      }
    }
    return null;
  }
/////////////////////

  readHive() async {
    //تم تاخير القراءة من ال
    //hive for 2second
    //لحل مشكلة ان ستايت القراءة بيجى قبل ستايت الكتابة
    await Future.delayed(const Duration(seconds: 10));
    BlocProvider.of<ReadCurrencyCubit>(context).readCurrency();
  }

  var latestRate;
  void readLatestRate() async {
    //var rateBox = await Hive.openBox<Map<String, dynamic>>(MyconstantName.latestRateBox);
    //await Future.delayed(const Duration(seconds: 10));
    //var rateBox = Hive.box(MyconstantName.latestRateBox);

    latestRate = await readFromHive();
  }

  Future<List<Map<String, dynamic>>> readFromHive() async {
    final box =
        await Hive.openBox<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);

    final result = box.toMap().map(
          (k, e) => MapEntry(
            k.toString(),
            Map<String, dynamic>.from(e),
          ),
        );
    //print('hive rate number is **${result.values.toList()[0].length}');
    return result.values.toList() ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    readHive();
    readLatestRate();
    super.initState();
  }

//////////////////////
  var currList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCurrencyCubit, ReadCurrencyState>(
      buildWhen: (previous, current) => current is ReadCurrencysuccessState,
      builder: (context, state) {
        if (state is ReadCurrencysuccessState) {
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
                                  .bodyLarge!
                                  .copyWith(color: Colors.black26),
                              hintText: 'Search Country',
                            ),
                            onFieldSubmitted: (val) {
                              sArg = val;
                              SearchedCurrList =
                                  searchedCurrency(val, state.currencyList) ??
                                      [];
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
                      child: Builder(builder: (context) {
                        return ListView.separated(
                          itemCount: state.currencyList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            // children: state.currencyList
                            //     .map((e) => CurrencyListDrawer(
                            //           Cur: e,
                            //         ))
                            //     .toList(),
                            return  ListTile(
                              title: Text(
                                  state.currencyList[index].countryName ??
                                      'known'),
                              subtitle: Text(
                                  state.currencyList[index].currencyName ??
                                      'known'),
                              leading:    CachedNetworkImage(
                      imageUrl: state.currencyList[index].icon!,
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                      placeholder: (context, url) =>
                          Image.asset('assets/images/Missing_flag.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/Missing_flag.png'),
                    ),
                            );
                            // CurrencyListDrawer(
                            //   Cur: state.currencyList[index],
                            // );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          /*  children: [
                            Card4(
                              Cur: allCur[0],
                            )
                          ],*/
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Drawer();
        }
      },
    );
  }
}
