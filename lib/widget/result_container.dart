// ignore_for_file: use_key_in_widget_constructors

import 'package:bmi/constants.dart';
import 'package:bmi/widget/custom_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ResultContainer extends StatelessWidget {
  final String status;
  final String bmi;
  final String tip;
  final Color statusColor;
  final VoidCallback onSavedPressed;

  const ResultContainer({
    required this.statusColor,
    required this.status,
    required this.bmi,
    required this.tip,
    required this.onSavedPressed,
  });

  @override
  Widget build(BuildContext context) {
    var bmig = double.parse(bmi);
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        depth: 8,
        lightSource: LightSource.topLeft,
        color: kBackgroundColor,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              status,
              style: kTextVariableStyle.copyWith(
                  fontWeight: FontWeight.bold, color: statusColor),
            ),
            Text(
              bmi.substring(0, bmi.indexOf(('.')) + 2),
              style: kNumberStyle.copyWith(color: kBlueColor),
            ),
            Text(
              'kg/m2',
              style: kTextVariableStyle.copyWith(
                color: kGreyColor,
              ),
            ),
            SfLinearGauge(
              minorTicksPerInterval: 4,
              useRangeColorForAxis: true,
              animateAxis: true,
              axisTrackStyle: const LinearAxisTrackStyle(thickness: 1),
              minimum: 10,
              maximum: 40,
              markerPointers: [
                LinearShapePointer(
                    borderWidth: 5,
                    value: bmig,
                    shapeType: LinearShapePointerType.diamond,
                    elevation: 5,
                    color: kBlueColor,
                    elevationColor: Colors.blue)
              ],
              ranges: const <LinearGaugeRange>[
                LinearGaugeRange(
                    startValue: 10,
                    endValue: 18.4,
                    position: LinearElementPosition.outside,
                    color: kYellowGauge),
                LinearGaugeRange(
                    startValue: 18.5,
                    endValue: 24.9,
                    position: LinearElementPosition.outside,
                    color: kGreenGauge),
                LinearGaugeRange(
                    startValue: 25.0,
                    endValue: 29.9,
                    position: LinearElementPosition.outside,
                    color: kOrangeGauge),
                LinearGaugeRange(
                    startValue: 30.0,
                    endValue: 40.0,
                    position: LinearElementPosition.outside,
                    color: kRedGauge),
              ],
            ),
            const SizedBox(height: 5),
            CustomButton('Save Result', onSavedPressed),
          ],
        ),
      ),
    );
  }
}
