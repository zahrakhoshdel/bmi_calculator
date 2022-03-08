// ignore_for_file: non_constant_identifier_names

import 'package:bmi/widget/advice_container.dart';
import 'package:bmi/widget/base/base_screen.dart';
import 'package:bmi/widget/custome_alert_dialog.dart';
import 'package:bmi/widget/result_container.dart';
import 'package:bmi/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ResultScreen extends StatefulWidget {
  final String status;
  final String bmi;
  final String moreTips;
  final String tip;
  final Color statusColor;
  final String minWeight;
  final String maxWeight;
  final String dminWeight;
  final String dmaxWeight;

  // ignore: use_key_in_widget_constructors
  const ResultScreen({
    required this.statusColor,
    required this.status,
    required this.bmi,
    required this.moreTips,
    required this.tip,
    required this.minWeight,
    required this.maxWeight,
    required this.dminWeight,
    required this.dmaxWeight,
  });

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  bool showWidget = false;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      onButtonPressed: () {
        onRecalculatePressed(context);
      },
      buttonText: 'RE-CALCULATE YOUR BMI',
      childWidget: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Your ',
                  style: kNumberStyle.copyWith(
                    color: kBlueColor,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Result',
                        style: kNumberStyle.copyWith(
                          color: kTextColor,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ResultContainer(
                bmi: widget.bmi,
                status: widget.status,
                statusColor: widget.statusColor,
                tip: widget.tip,
                onSavedPressed: () {
                  setState(() {
                    onSavePressed(
                      widget.bmi,
                      widget.status,
                      widget.statusColor,
                    );
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              widget.status != 'Normal'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'advice: ',
                            style: kTextVariableStyle.copyWith(
                              color: widget.statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.tip,
                                style: kTextVariableStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        showWidget
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.moreTips,
                                      style: kTextVariableStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text:
                                            'Healthy weight range for your height:',
                                        style: kTextVariableStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                ' ${widget.minWeight}kg - ${widget.maxWeight}kg',
                                            style: kTextVariableStyle.copyWith(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Aim to ${widget.status != 'Under Weight' ? 'lose' : 'weight gain'} ${widget.dminWeight}kg - ${widget.dmaxWeight}kg ',
                                      style: kTextVariableStyle,
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      setState(() {
                                        showWidget = !showWidget;
                                      });
                                    },
                                    style: NeumorphicStyle(
                                      color: Colors.white,
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(15)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 20),
                                    child: const Text('more'),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : AdviceContainer(
                      statusColor: widget.statusColor,
                      tip: widget.tip,
                      moreTips: widget.moreTips,
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onRecalculatePressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomeAlertDialog();
        });
  }

  void onSavePressed(bmi, String status, statusColor) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.clear();
      List<String> saveList = prefs.getStringList('saveList') ?? [];

      bmi = bmi.substring(0, bmi.indexOf(('.')) + 2);
      status = status;
      String colorString = statusColor.toString(); // Color(0x12345678)
      statusColor = colorString.split('(0x')[1].split(')')[0];
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

      saveList.add(
          '{"bmi": "${bmi}", "status": "${status}", "statusColor": "${statusColor}", "formattedDate":"${formattedDate}"}');

      await prefs.setStringList('saveList', saveList);
      //print(prefs.getStringList('saveList') ?? []);
    } catch (e) {
      print(e);
    }
  }
}
