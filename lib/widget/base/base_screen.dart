// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:bmi/widget/custom_button.dart';
import 'package:bmi/widget/base/navigation_drawer.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  final Widget childWidget;
  final VoidCallback onButtonPressed;
  final String buttonText;

  const BaseScreen({
    required this.childWidget,
    required this.onButtonPressed,
    required this.buttonText,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.more_vert),
            color: kTextColor,
          ),
          centerTitle: true,
          title: const Text(
            'bmi',
            style: TextStyle(color: kTextColor, fontWeight: FontWeight.w400),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: widget.childWidget,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(widget.buttonText, widget.onButtonPressed),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        drawer: const NavigationDrawer(),
      ),
    );
  }
}
