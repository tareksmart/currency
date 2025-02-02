import 'package:currencypro/view/pages/home_page_mobile_layout.dart';
import 'package:currencypro/view/pages/home_page_tab_layout.dart';
import 'package:currencypro/view/widget/adaptive_layout.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
        mobileLayout: (context) => const HomePageMobileLayout(),
        tabletLayout: (context) => const HomePageTabLayout());
  }
}
