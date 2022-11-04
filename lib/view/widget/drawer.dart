import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.ButtonColor,
      child: Drawer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * .7,
                ),
                Icon(Icons.close)
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Search Country',
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
