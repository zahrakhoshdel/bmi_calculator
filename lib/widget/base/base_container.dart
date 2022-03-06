// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';

class BaseContainer extends StatelessWidget {
  final Widget childWidget;

  const BaseContainer({required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 5,
                spreadRadius: 3),
            BoxShadow(
                color: kBlueColor.withOpacity(0.2),
                offset: const Offset(4, 4),
                blurRadius: 5,
                spreadRadius: 1)
          ],
        ),
        child: Center(
          child: childWidget,
        ),
      ),
    );
  }
}
