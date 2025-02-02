import 'package:cached_network_image/cached_network_image.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/services/hive_services.dart';
import 'package:currencypro/view/widget/waiting_alert_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import 'not used widget/currency_list_drawer.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, required this.size}) : super(key: key);
  final Size size;
  // final List<CurrencyData> allCur;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<CurrencyData> searchedList = [];
  String sArg = "";
  List<CurrencyData> SearchedCurrList = [];
  TextEditingController searchController = TextEditingController();
  late SpeechToText _speechToText;
  bool _speechEnabled = false;
  String lastWords = '';
  List<LocaleName> _localeNames = [];
  HiveSevices hiveSevices = HiveSevices();
  List<Map<dynamic, dynamic>> latestRate = [];
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
  readLatestRate() async {
    latestRate = await hiveSevices.readFromHiveLatestRate();
  }

  @override
  void initState() {
    // TODO: implement initState

    hiveSevices.readHive(context);

    readLatestRate();

    _speechToText = SpeechToText();

    super.initState();

    _initSpeech();
    searchController.addListener(() {
      setState(() {
        SearchedCurrList.clear();
        SearchedCurrList =
            searchedCurrency(searchController.text.toLowerCase(), currList) ??
                [];
      });
      print('************** listener');
    });
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    // _localeNames = await _speechToText.locales();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: "en_US",
    );
    print('**********listn start');
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    print('**********listn stop');

    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      searchController.value = TextEditingValue(text: lastWords.toLowerCase());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    debugPrint('dezposing**************************************');
    searchController.dispose();
    closeCubit();
    super.dispose();
  }

  void closeCubit() async {
    await ReadCurrencyCubit().close();
  }

//////////////////////
  List<CurrencyData> currList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCurrencyCubit, ReadCurrencyState>(
      buildWhen: (previous, current) => current is ReadCurrencysuccessState,
      builder: (context, state) {
        if (state is ReadCurrencyWaitingState)
          WaitingAlertDialog(
            title: 'please wait',
          );
        if (state is ReadCurrencysuccessState && mounted) {
          currList = state.currencyList;
          return SizedBox(
            height: 850,
            child: Drawer(
              backgroundColor: MyColors.drawerColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
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
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Scaffold.of(context).closeDrawer();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          SizedBox(
                            child: Card(
                              elevation: 10,
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.black26),
                                  hintText: 'Search Country',
                                ),
                                onChanged: (val) {
                                  SearchedCurrList.clear();
                                  SearchedCurrList = searchedCurrency(
                                          searchController.text, currList) ??
                                      [];

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      //excute
                                      _speechToText.isNotListening
                                          ? _startListening()
                                          : _stopListening();

                                      setState(() {});
                                    },
                                    icon: Icon(
                                      (_speechToText.isNotListening ||
                                              _speechToText.hasError)
                                          ? Icons.mic_off
                                          : Icons.mic,
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
                      height: widget.size.height * 0.6,
                      // width: 300,
                      child: ExpandableTheme(
                        data: const ExpandableThemeData(
                          iconColor: Colors.blue,
                          useInkWell: true,
                        ),
                        child: Builder(builder: (context) {
                          return ListView.separated(
                            itemCount: checkCurrList(currList, SearchedCurrList)
                                .length,
                            shrinkWrap: false,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              // children: state.currencyList
                              //     .map((e) => CurrencyListDrawer(
                              //           Cur: e,
                              //         ))
                              //     .toList(),
                              return ExpansionTile(
                                title: Text(checkCurrList(
                                            currList, SearchedCurrList)[index]
                                        .countryName ??
                                    ''),
                                leading: CachedNetworkImage(
                                  imageUrl: state.currencyList[index].icon!,
                                  fit: BoxFit.contain,
                                  width: 30,
                                  height: 30,
                                  placeholder: (context, url) => Image.asset(
                                      'assets/images/Missing_flag.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/images/Missing_flag.png'),
                                ),
                                children: [
                                  Text(checkCurrList(
                                          currList, SearchedCurrList)[index]
                                      .currencyName
                                      .toString()),
                                  if (latestRate.length > 0 && mounted)
                                    Text(latestRate[0][checkCurrList(currList,
                                                SearchedCurrList)[index]
                                            .currencyCode
                                            .toString()] ??
                                        'KNOWN')
                                  else
                                    const LinearProgressIndicator(),
                                ],
                              );
                              // CurrencyListDrawer(
                              //   Cur: state.currencyList[index],
                              // );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
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
            ),
          );
        } else {
          return Drawer();
        }
      },
    );
  }

  List<CurrencyData> checkCurrList(
      List<CurrencyData> allCurrList, List<CurrencyData> SearchedCurrList) {
    if (SearchedCurrList.isNotEmpty) {
      return searchedList;
    } else {
      return allCurrList;
    }
  }
}
