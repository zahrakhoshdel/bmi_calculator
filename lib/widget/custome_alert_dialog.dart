import 'package:bmi/screens/home_screen.dart';
import 'package:bmi/widget/custom_button.dart';
import 'package:flutter/material.dart';

class CustomeAlertDialog extends StatelessWidget {
  const CustomeAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'would you reset your BMI data?',
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton('yes', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          }),
          CustomButton('no', () {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
