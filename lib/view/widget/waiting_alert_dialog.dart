import 'package:flutter/material.dart';

class WaitingAlertDialog extends StatelessWidget {
   WaitingAlertDialog({
    super.key,
    required this.title,this.progressColor
  });
  String title;
  Color? progressColor;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      icon: LinearProgressIndicator(
        color:progressColor?? Colors.green,
      ),
      elevation: 16,
    );
  }
}
