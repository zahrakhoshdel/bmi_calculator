// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: kBlueColor,
      splashColor: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
