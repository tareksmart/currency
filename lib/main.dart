import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/latest_currency/latest_curr_cubit_cubit.dart';
import 'package:currencypro/repo/currency_repository.dart';
import 'package:currencypro/services/wep_services.dart';
import 'package:currencypro/view/pages/myHomePage.dart';
import 'package:currencypro/view/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
          BlocProvider(create: (context)=>CurrencyCubit()),
          BlocProvider(create: (context)=>LatestCurrCubitCubit())
        ],
        child: MyHomePage(),
      ),
    );
  }
}
