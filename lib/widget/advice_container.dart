// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:flutter/material.dart';

class AdviceContainer extends StatelessWidget {
  final String tip;
  final String moreTips;
  final Color statusColor;

  const AdviceContainer({
    required this.statusColor,
    required this.tip,
    required this.moreTips,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'advice: ',
        style: kTextVariableStyle.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            height: 3),
        children: <TextSpan>[
          TextSpan(
            text: tip,
            style: kTextVariableStyle.copyWith(
              fontWeight: FontWeight.normal,
              height: 1.2,
            ),
          ),
          TextSpan(
            text: moreTips,
            style: kTextVariableStyle.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
