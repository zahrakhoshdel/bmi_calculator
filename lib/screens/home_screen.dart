// ignore_for_file: non_constant_identifier_names

import 'package:bmi/constants.dart';
import 'package:bmi/widget/base/base_screen.dart';
import 'package:bmi/widget/gender_container.dart';
import 'package:bmi/widget/height_container.dart';
import 'package:bmi/widget/selector_container.dart';
import 'package:flutter/material.dart';
import 'package:bmi/screens/result_screen.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMaleActive = true;

  int age = 19, weight = 74;

  double height = 180;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onButtonPressed: () {
        my_navigator();
      },
      buttonText: 'CALCULATE YOUR BMI',
      childWidget: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Body mass index (BMI) ',
            ),
            Row(
              children: [
                GenderContainer(
                  text: 'Male',
                  avatar: 'assets/boy1.png',
                  isActive: isMaleActive,
                  onTapped: () {
                    setState(() {
                      isMaleActive = true;
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                GenderContainer(
                  text: 'Female',
                  avatar: 'assets/girl2.png',
                  isActive: !isMaleActive,
                  onTapped: () {
                    setState(() {
                      isMaleActive = false;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                HeightContainer(
                  height,
                  (double value) {
                    setState(() {
                      height = value.round() * 1.0;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                SelectorContainer(
                  title: 'age',
                  number: age.toString(),
                  increase: () {
                    changeNumbers(isAgeChanging: true, isIncreasing: true);
                  },
                  decrease: () {
                    changeNumbers(isAgeChanging: true, isIncreasing: false);
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                SelectorContainer(
                  title: 'weight',
                  number: weight.toString(),
                  increase: () {
                    changeNumbers(isAgeChanging: false, isIncreasing: true);
                  },
                  decrease: () {
                    changeNumbers(isAgeChanging: false, isIncreasing: false);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void changeNumbers({
    required bool isAgeChanging,
    required bool isIncreasing,
  }) {
    if (isAgeChanging) {
      setState(() {
        if (isIncreasing) {
          if (age < 120) {
            age++;
          } else {
            // pass
          }
        } else {
          if (age > 1) {
            age--;
          } else {
            // pass
          }
        }
      });
    } //
    else {
      setState(() {
        if (isIncreasing) {
          if (weight < 500) {
            weight++;
          } else {
            // pass
          }
        } else {
          if (weight > 5) {
            weight--;
          } else {
            // pass
          }
        }
      });
    }
  }

  void my_navigator() {
    List result = bmiCalculator();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResultScreen(
            statusColor: result[2],
            status: result[1],
            bmi: result[0].toString(),
            tip: result[3],
            moreTips: result[4],
            minWeight: result[5].toString(),
            maxWeight: result[6].toString(),
            dminWeight: result[7].toString(),
            dmaxWeight: result[8].toString(),
          );
        },
      ),
    );
  }

  List bmiCalculator() {
    double bmi = 0;
    String tip;
    String moreTips;
    Color statusColor;
    String status;
    double minWeight = 0, maxWeight = 0;
    double dminWeight = 0, dmaxWeight = 0;
    bmi = weight / pow((height / 100), 2);
    minWeight = (18.5 * pow((height / 100), 2)).ceilToDouble();
    maxWeight = (25.0 * pow((height / 100), 2)).floorToDouble();

    dminWeight = (weight - minWeight).abs();
    dmaxWeight = (weight - maxWeight).abs();

    if (bmi < 18.5) {
      status = 'Under Weight';
      tip =
          'Being underweight could be a sign youre not eating enough or you may be ill. ';
      moreTips = '\nIf youre underweight, a GP can help.';
      statusColor = kYellowGauge;
    } else if (bmi >= 18.5 && bmi <= 25) {
      status = 'Normal';
      statusColor = Colors.greenAccent;
      tip = 'Keep up the good work!';
      moreTips =
          '\nFor tips on maintaining a healthy weight, check out the food and diet and fitness sections.';
    } else if (bmi > 25 && bmi <= 30) {
      status = 'Over Weight';
      tip =
          'The best way to lose weight if you are overweight is through a combination of diet and exercise.';
      moreTips =
          '\nThe BMI calculator will give you a personal calorie allowance to help you achieve a healthy weight safely.';
      statusColor = kOrangeGauge;
    } else {
      status = 'Obese';
      tip =
          'The best way to lose weight if you are obese is through a combination of diet and exercise.';
      moreTips =
          '\nand, in some cases, medicines. See a GP for help and advice.';
      statusColor = kRedGauge;
    }

    return [
      bmi,
      status,
      statusColor,
      tip,
      moreTips,
      minWeight,
      maxWeight,
      dminWeight,
      dmaxWeight,
    ];
  }
}
