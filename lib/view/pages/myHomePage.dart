import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/currency_states.dart';
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
    _currLoad();
    _allRate();
  }

  _currLoad() async {
    await BlocProvider.of<CurrencyCubit>(context, listen: false)
        .getAllCurrData();
  }

  _allRate() async {
    await BlocProvider.of<CurrencyCubit>(context).getRates();
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
              allCur = state.currencisList.cast<CurrencyData>();
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
                                    onPress: () {},
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
                BlocBuilder<CurrencyCubit, CurrencyState>(
                  buildWhen: (previous, current) =>
                      current is CurrenciesLoaded && current is RateLoaded,
                  builder: (context, state) {
                    print('satte isssssssss $state');
                    if (state is CurrencyWaitingState) {
                      print('satte isssssssss $state');
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CurrenciesLoaded ||
                        state is RateLoaded) {
                      if (state is CurrenciesLoaded)
                        allCur = state.currencisList;
                      if (state is RateLoaded) allRate = state.ratesList;
                      // if (allRate != null && allCur != null) {

                        return Currencycard(
                          allCurrency: allCur ?? defaultList,
                          allRate: allRate,
                        );
                      // } else
                      //   return const Center(
                      //     child: Text('no data allCur '),
                      //   );
                    } else
                      return const Center(
                        child: Text('no data'),
                      );
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
