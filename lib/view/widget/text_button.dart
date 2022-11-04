import 'package:currencypro/controller/cubit/curency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({Key? key, required this.onPress, required this.index})
      : super(key: key);

  final VoidCallback onPress;
  final int index;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CurrencyCubit>(context, listen: false);
    if (index == 0) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('7'),
        text: '7',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 1) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('8'),
        text: '8',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 2) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('9'),
        text: '9',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 3) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('4'),
        text: '4',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 4) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('5'),
        text: '5',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 5) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('6'),
        text: '6',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 6) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('1'),
        text: '1',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 7) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('2'),
        text: '2',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 8) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('3'),
        text: '3',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 9) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('0'),
        text: '0',
        selectedTextColor: Colors.black,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            fontWeight: FontWeight.w500,
            color: Colors.blue),
        animatedOn: AnimatedOn.onTap,
      );
    } else if (index == 10) {
      return AnimatedButton(
        onPress: () => bloc.getNumber('.'),
        text: '.',
        selectedTextColor: Colors.red,
        transitionType: TransitionType.BOTTOM_TO_TOP,
        isReverse: true,
        textStyle: const TextStyle(
            fontSize: 32,
            letterSpacing: 5,
            color: Colors.blue,
            fontWeight: FontWeight.w500),
      );
    } else if (index == 11) {
      return TextButton(
        onPressed: () => bloc.getNumber(''),
        child: const Icon(Icons.backspace),
      );
    } else
      return Text('');
  }
}
