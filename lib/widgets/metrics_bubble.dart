import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metrics_bubble_flutter/styles/styles.dart';

/*
MetricsBubbleWidget is a stateful widget that displays a "bubble" of user inputted metrics.

The styling for this widget are found in styles/styles.dart

Parameters:
  1. label - String - This is  of the bubble (e.g. "Upper Body", "Core", etc.)
  2. weight - int - This is the value in the middle of the bubble: Restrictions are 0 - 350
  3. unit - String - This is a constant value of "lbs"
  4. background - SvgPicture - This is a constsant svg image that appears in the background of the bubble
*/
class MetricsBubbleWidget extends StatefulWidget {
  final String label;
  final int weight;
  final String unit;
  final SvgPicture background;

  const MetricsBubbleWidget(
      {Key? key,
      required this.label,
      required this.weight,
      required this.unit,
      required this.background})
      : super(key: key);

  @override
  _MetricsBubbleWidgetState createState() => _MetricsBubbleWidgetState();
}

class _MetricsBubbleWidgetState extends State<MetricsBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: bubbleDiameter.toDouble(),
      height: bubbleDiameter.toDouble(),
      decoration: bubbleBoxDecoration,
      // We use a stack to layer the svg image behind the text
      child: Stack(
        children: [
          // We use positioned to adjust the position of the svg image
          Positioned(
            child: widget.background,
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
          ),
          // This allows us to center the "bubble"
          Center(
            child: Column(
              // This allows us to center the text inside the "bubble"
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: labelTextStyle,
                ),
                Text(
                  // Convert the integer to a string
                  widget.weight.toString(),
                  style: weightTextStyle,
                ),
                Text(
                  widget.unit,
                  style: unitTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
