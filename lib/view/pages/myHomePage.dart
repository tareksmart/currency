import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  TextEditingController _baseCurrency_controller = TextEditingController();
  TextEditingController _toCurr_controller = TextEditingController();
  final _globalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
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
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: size.height * .6,
                    child: AnimationLimiter(
                      child: GridView.count(
                        crossAxisSpacing: .5,
                        crossAxisCount: 3,
                        children: List.generate(
                            12,
                            (index) => AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(seconds: 1),
                                  columnCount: 3,
                                  child: ScaleAnimation(
                                      child: FadeInAnimation(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: MyColors.whiteColor),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          '9',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ),
                                  )),
                                )),
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
                  child: SizedBox(
                    height: size.height * .3,
                    width: size.width * .9,

                    child: Card(
                      color: MyColors.primaryColor,
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: _globalKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'usd',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(width: 4,),

                                  Expanded(
                                    child: TextFormField(
                                      controller: _baseCurrency_controller,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              Theme.of(context).textTheme.subtitle2),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'inr',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  //TextFormField()
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
