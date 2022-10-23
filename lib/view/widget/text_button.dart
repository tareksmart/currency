import 'package:currencypro/view/constant/myConstants.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({Key? key, required this.onPress, required this.index})
      : super(key: key);

  final VoidCallback onPress;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return TextButton(
          onPressed: onPress,
          child: Text(
            '7',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
               ,
          ));
    } else if (index == 1) {
      return TextButton(onPressed: onPress, child: Text('8',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 2) {
      return TextButton(onPressed: onPress, child: Text('9',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 3) {
      return TextButton(onPressed: onPress, child: Text('4',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 4) {
      return TextButton(onPressed: onPress, child: Text('5',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 5) {
      return TextButton(onPressed: onPress, child: Text('6',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 6) {
      return TextButton(onPressed: onPress, child: Text('1',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 7) {
      return TextButton(onPressed: onPress, child: Text('2',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 8) {
      return TextButton(onPressed: onPress, child: Text('3',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 9) {
      return TextButton(onPressed: onPress, child: Text('0',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 10) {
      return TextButton(onPressed: onPress, child: Text('.',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 32)
        ,));
    } else if (index == 11) {
      return TextButton(onPressed: onPress, child: const Icon(Icons.backspace));
    } else
      return Text('');
  }
}
