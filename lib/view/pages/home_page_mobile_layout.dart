import 'package:currencypro/controller/cubit/hive_cubit/add_currency_data_hive_cubit/add_currency_data_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/all_currency_cubit/currency_states.dart';
import 'package:currencypro/controller/cubit/hive_cubit/read_currency_hive_cubit/cubit/read_currency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/services/hive_services.dart';
import 'package:currencypro/view/widget/curr_card_mobile.dart';
import 'package:currencypro/view/widget/digitals_widget.dart';
import 'package:currencypro/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/currency_data.dart';
import '../constant/myConstants.dart';
import '../widget/curr_card_tab.dart';
import '../widget/text_button.dart';

class HomePageMobileLayout extends StatefulWidget {
  const HomePageMobileLayout({Key? key}) : super(key: key);

  @override
  State<HomePageMobileLayout> createState() => _HomePageMobileLayoutState();
}

class _HomePageMobileLayoutState extends State<HomePageMobileLayout> {
  late final HiveSevices hiveSevices;
  @override
  void initState() {
    hiveSevices = HiveSevices();
    // TODO: implement initState
    hiveSevices.futureList(context);
    super.initState();
    //_currLoad();
  }

  @override
  Widget build(BuildContext context) {
    var allCur, allRate;
    final size = MediaQuery.sizeOf(context);
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
        // title: Text(
        //   'Currency Converter',
        //   style: Theme.of(context)
        //       .textTheme
        //       .headlineMedium!
        //       .copyWith(fontFamily: 'Roboto', color: MyColors.whiteColor),
        // ),
        elevation: 0,
      ),
      drawer: MyDrawer(size: size),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: MyColors.ButtonColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
                child: const SizedBox(
                  height: 300
                  ,
                  width: double.infinity,
                ),
              ),
               SizedBox(
                height:size.height*.2,
              ),
              const Expanded(child: SizedBox(height: 700, child: DigitalWidget())),
            ],
          ),
          Column(
            children: [
              // SizedBox(
              //   height: size.height * .05,
              // ),
              BlocConsumer<CurrencyCubit, CurrencyState>(
                buildWhen: (previous, current) => current is CurrenciesLoaded,
                listener: (context, state) {
                  if (state is CurrenciesLoaded) {
                    allCur = state.currencisList;
                    hiveSevices.triggerHiveCubit(allCur, context);
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
                    //return CurrencycardMobile();
                  }
                  return  Container();
                },
              ),
              BlocConsumer<LatestCurrCubit, LatestCurrCubitState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is LatestRateSuccessLoaded) {
                    hiveSevices.saveRate(state.currencyRatesModel.rates);

                    print(
                        '=*******rate number is ${state.currencyRatesModel.rates.length}');
                  }
                },
                builder: (context, state) {
                  hiveSevices.readHive(context);
                  hiveSevices.readFromHiveLatestRate();

                  return CurrencycardMobile(size:size);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
