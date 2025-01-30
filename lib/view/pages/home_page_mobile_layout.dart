import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/view/widget/curr_card_mobile.dart';
import 'package:currencypro/view/widget/digitals_widget.dart';
import 'package:currencypro/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import '../widget/curr_card.dart';
import '../widget/text_button.dart';

class HomePageMobileLayout extends StatefulWidget {
  HomePageMobileLayout({Key? key}) : super(key: key);

  @override
  State<HomePageMobileLayout> createState() => _HomePageMobileLayoutState();
}

class _HomePageMobileLayoutState extends State<HomePageMobileLayout> {
  @override
  void initState() {
    // TODO: implement initState
    _futureList();
    super.initState();
    //_currLoad();
  }

  _futureList() async {
    var dateBox = Hive.box<String>(MyconstantName.dateAddHiveBox);
    var currBox = Hive.box<CurrencyData>(MyconstantName.currencyDataBox);
    var rateBox = Hive.box<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);

    var date = dateBox.get(MyconstantName.addDateKeyName);
    var addCubit = BlocProvider.of<AddCurrencyDataCubit>(context);
    var datenow = addCubit.dateFormat(DateTime.now());
    if (date != addCubit.dateFormat(DateTime.now()) ||
        rateBox.length <= 0 ||
        currBox.length <= 0) {
      await currBox.deleteFromDisk();
      await dateBox.deleteFromDisk();
      await rateBox.deleteFromDisk();

      await BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
      await BlocProvider.of<LatestCurrCubit>(context).getRates();
    }
  }

  void triggerHiveCubit(var allCurrency) async {
    await BlocProvider.of<AddCurrencyDataCubit>(context)
        .addCurrencyData(allCurrency);
    print('*********triggerHiveCubit');
  }

  saveRate(Map<dynamic, dynamic> ratesMap) async {
    try {
      var latestBox = await Hive.openBox<Map<dynamic, dynamic>>(
          MyconstantName.latestRateBox);

      // Hive.box<Map<dynamic, dynamic>>(MyconstantName.latestRateBox);
      await Future.delayed(const Duration(seconds: 10));
      await latestBox.put('latestRate', ratesMap);
      print('*****saving rate to hive');
    } catch (e) {
      print('*****saving rate to hive${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var allCur, allRate;
    final size = MediaQuery.of(context).size;
    List<CurrencyData> defaultList = [
      CurrencyData(
          currencyCode: 'USD',
          countryName: 'dollar',
          icon: 'https://currencyfreaks.com/photos/flags/pkr.png?v=0.1')
    ];
    Map<dynamic, dynamic> defAllRate = {'Egy': 49, 'Fiji Dollar': 12};

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.ButtonColor,
        title: Text(
          'Currency Converter',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontFamily: 'Roboto', color: MyColors.whiteColor),
        ),
        elevation: 0,
      ),
      drawer: MyDrawer(size: size),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Positioned(
                top: 800,
                child: SingleChildScrollView(
                    child: SizedBox(height: 400, child: DigitalWidget())),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: size.height * .05,
              ),
              BlocConsumer<CurrencyCubit, CurrencyState>(
                buildWhen: (previous, current) => current is CurrenciesLoaded,
                listener: (context, state) {
                  if (state is CurrenciesLoaded) {
                    allCur = state.currencisList;
                    triggerHiveCubit(allCur);
                  }
                },
                builder: (context, state) {
                  print('satte isssssssss $state');
                  if (state is CurrencyWaitingState) {
                    print('satte isssssssss $state');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FailurLoaded) {
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(state.errorMessage),
                            ),
                          );
                        });
                  } else {
                    return CurrencycardMobile(
                        allCurrency: allCur ?? defaultList,
                        allRate: allRate ?? defAllRate);
                  }
                  return Text('no data');
                },
              ),
              BlocConsumer<LatestCurrCubit, LatestCurrCubitState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is LatestRateSuccessLoaded) {
                    saveRate(state.currencyRatesModel.rates);
                    print(
                        '=*******rate number is ${state.currencyRatesModel.rates.length}');
                  }
                },
                builder: (context, state) {
                  return Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
