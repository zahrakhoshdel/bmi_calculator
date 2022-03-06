// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CircleButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CircleButton({
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: const NeumorphicStyle(
        color: Colors.white,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Icon(
        iconData,
        color: kGreyColor,
      ),
    );
  }
}
