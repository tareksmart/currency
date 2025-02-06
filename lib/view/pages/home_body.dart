import 'package:currencypro/view/pages/home_page_mobile_layout.dart';
import 'package:currencypro/view/pages/home_page_tab_layout.dart';
import 'package:currencypro/view/widget/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
Future<void> _restartApp()async{
  await Restart.restartApp(
   
    notificationTitle: 'Restarting App',
    notificationBody: 'Please tap here to open the app again.',
  );
}
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _restartApp,
      child: AdaptiveLayout(
          mobileLayout: (context) => const HomePageMobileLayout(),
          tabletLayout: (context) => const HomePageTabLayout()),
    );
  }
}
