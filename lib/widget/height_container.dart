// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:bmi/widget/base/base_container.dart';
import 'package:flutter/material.dart';

class HeightContainer extends StatelessWidget {
  final double height;
  final Function(double value) onChanged;

  const HeightContainer(this.height, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      childWidget: Column(
        children: [
          const Text(
            'HEIGHT',
            style: kTextVariableStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                height.toString().replaceFirst('.0', ''),
                style: kNumberStyle,
              ),
              Text(
                'cm',
                style: kTextVariableStyle.copyWith(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Slider(
            value: height,
            min: 30,
            max: 240,
            onChanged: onChanged,
            activeColor: kBlueColor,
            inactiveColor: Colors.white,
          )
        ],
      ),
    );
  }
}
