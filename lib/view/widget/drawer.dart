import 'package:flutter/material.dart';

import '../constant/myConstants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.backGroundTextFieldColor,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .7,
                  height: size.height * .06,
                ),
                const Icon(Icons.close)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  SizedBox(
                    width: size.width * .8,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black26),
                        hintText: 'Search Country',
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('hello')),
                      Divider(
                        thickness: 6,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Text('hello'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * .017,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * .6,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.mic_none,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
