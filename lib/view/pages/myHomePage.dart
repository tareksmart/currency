import 'package:currencypro/view/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../constant/myConstants.dart';
import '../widget/curr_card.dart';
import '../widget/text_button.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/images/waves.png',
          fit: BoxFit.cover,
        ),
      ),
      drawer: MyDrawer(size: size),
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
                Currencycard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
