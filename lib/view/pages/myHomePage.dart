import 'package:currencypro/controller/cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

    super.initState();
    //_currLoad();
    _futureList();
    //  _allRate();
  }

  // _currLoad() async {
  //   await BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
  //   await BlocProvider.of<CurrencyCubit>(context).getRates();
  // }

  _futureList() async {
    await BlocProvider.of<CurrencyCubit>(context).getAllCurrData();
    await BlocProvider.of<CurrencyCubit>(context).getRates();
  }
  // _allRate() async {
  //   await BlocProvider.of<LatestCurrCubit>(context).getRates();
  // }

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
    Map<String, dynamic> defAllRate = {'Egy': 49, 'Fiji Dollar': 12};

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/waves.png',
          fit: BoxFit.cover,
        ),
      ),
      drawer: BlocConsumer<CurrencyCubit, CurrencyState>(
          listener: (context, state) {
            if (state is CurrenciesLoaded) {
              allCur = state.currencisList;
              print('drawer****************************');
            }
          },
          buildWhen: (previous, current) => current is CurrenciesLoaded,
          builder: (context, state) {
            if (allCur != Null) {
              return MyDrawer(
                size: size,
                allCur: allCur ?? defaultList,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
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
                  height: size.height * .03,
                ),
                BlocConsumer<CurrencyCubit, CurrencyState>(
                  buildWhen: (previous, current) => current is CurrenciesLoaded,
                  listener: (context, state) {
                    if (state is CurrenciesLoaded) {
                      allCur = state.currencisList;
                      List<CurrencyData> curList = state.currencisList;
                      curList.map((currencyData) async {
                        await BlocProvider.of<AddCurrencyDataCubit>(context)
                            .addCurrencyData(currencyData);
                        print('save to db');
                      });
                      print('save to db');
                    }

                    if (state is LatestRateSuccessLoaded) {
                      allRate = state.ratesList;
                
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
                          builder: (context) => Text(state.errorMessage));
                    }
                    return Currencycard(
                        allCurrency: allCur ?? defaultList,
                        allRate: allRate ?? defAllRate);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
