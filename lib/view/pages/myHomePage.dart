import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import '../widget/curr_card.dart';
import '../widget/text_button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    _futureList();
    super.initState();
    //_currLoad();
  }

  // _currLoad() async {
  //   await BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
  //   await BlocProvider.of<CurrencyCubit>(context).getRates();
  // }

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
  void dispose() {
    // TODO: implement dispose

    super.dispose();
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
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/waves.png',
          fit: BoxFit.cover,
        ),
      ),
      drawer: MyDrawer(size: size),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .35,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/waves.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .15,
                  ),
                  SizedBox(
                    height: size.height * .6,
                    child: AnimationLimiter(
                      child: GridView.count(
                        childAspectRatio: 2,
                        crossAxisSpacing: .5,
                        crossAxisCount: 3,
                        children: List.generate(
                          12,
                          (index) => AnimationConfiguration.staggeredGrid(
                            position: 10,
                            duration: const Duration(seconds: 1),
                            columnCount: 3,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MyColors.whiteColor),
                                  child: MyTextButton(
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
                      //   debugPrint(allCur);
                      triggerHiveCubit(allCur);
                    }
                    // if (state is LatestRateSuccessLoaded) {
                    //   allRate = state.ratesList;
                    // }
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
                    }
                    return Currencycard(
                        allCurrency: allCur ?? defaultList,
                        allRate: allRate ?? defAllRate);
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
      ),
    );
  }
}
