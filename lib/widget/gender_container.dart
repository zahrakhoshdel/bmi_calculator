// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:flutter/material.dart';

class GenderContainer extends StatelessWidget {
  final String text;
  final String avatar;
  final bool isActive;
  final VoidCallback onTapped;
  const GenderContainer({
    required this.text,
    required this.isActive,
    required this.avatar,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Material(
              elevation: 10,
              shadowColor: isActive ? kBlueColor : Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onTapped,
                customBorder: const CircleBorder(),
                splashColor: kBlueColor,
                child: Container(
                    width: 150,
                    height: 150,
                    foregroundDecoration: isActive
                        ? null
                        : const BoxDecoration(
                            color: Colors.grey,
                            backgroundBlendMode: BlendMode.lighten,
                          ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: isActive
                            ? [kBlueColor, Colors.white]
                            : [kGreyColor, Colors.white],
                      ),
                      image: DecorationImage(
                        image: AssetImage(avatar),
                        //fit: BoxFit.cover,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isActive ? kTextColor : Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
