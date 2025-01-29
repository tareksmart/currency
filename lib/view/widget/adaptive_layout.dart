import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({super.key, required this.mobileLayout, required this.tabletLayout});
  //تم استخدام widget builder
  //هى عباره عن دالة او ميثود بترجع ويدجت
  //تم استخدامها بدل ما نستخدم اوبجكت من موبايل او تابلت مباشرة
  //لان الاوبجكتات التلاته بيتم انشائهم بالفعل حتى لو كنت فى وضع ال التابلت مثلا او وضع الموبايل فقط لكن الدالة اللى استخدمناها بترجع اوبجكت من الوضع الحالى فقط او بتنشا 
  //اوبجكت من الموبايل لوكان الوضع موبايل او تابلت لوكان الوضع تابلت
  final WidgetBuilder mobileLayout;
  final WidgetBuilder tabletLayout;
 

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context, Constraints) {
     
      if (Constraints.maxWidth < 600) {
        return  mobileLayout(context);
      } else  {
        return  tabletLayout(context);
      } 
    });
  }
}


