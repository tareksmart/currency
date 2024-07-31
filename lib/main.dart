import 'package:currencypro/controller/cubit/all_currency_cubit/curency_cubit.dart';
import 'package:currencypro/controller/cubit/latest_currency_cubit/latest_curr_cubit_cubit.dart';
import 'package:currencypro/controller/cubit/press_number_cubit/press_number_cubit_cubit.dart';
import 'package:currencypro/repo/currency_repository.dart';
import 'package:currencypro/services/wep_services.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/pages/myHomePage.dart';
import 'package:currencypro/view/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(MyconstantName.currencyDataBox);
  runApp(BlocProvider(create: (context) => CurrencyCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  late CurrencyRepository currRepo;
  late CurrencyCubit cubit = CurrencyCubit();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme(context),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CurrencyCubit()),
          // BlocProvider(create: (context)=>LatestCurrCubit()),
          BlocProvider(create: (context) => PressNumberCubit())
        ],
        child: MyHomePage(),
      ),
    );
  }
}
