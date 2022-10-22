import 'package:currencypro/view/widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:currencypro/view/pages/myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme(context),
      home:  MyHomePage(),
    );
  }
}
