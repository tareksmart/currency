import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:currencypro/controller/currency_repository.dart';
import 'package:currencypro/view/constant/myConstants.dart';
import 'package:currencypro/view/widget/convert_button.dart';
import 'package:currencypro/view/widget/text_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widget/curr_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .4,
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
                                      child: MyTextButton(index: index,onPress: (){},),
                                    ),
                                  )),
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
                  height: size.height * .15,
                ),
                Align(
                  alignment: Alignment.center,
                  child:
                       Currencycard(),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * .5,
                ),
                Align(
                  alignment: Alignment.center,
                  child:ConvertButton(text: 'CONVERT', onTab: () async {

                  },size: size,) ,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
