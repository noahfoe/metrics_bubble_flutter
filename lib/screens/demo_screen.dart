import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metrics_bubble_flutter/widgets/metrics_bubble.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  // TextEditingControllers are used for the TextFormFields
  final _labelController = TextEditingController();
  final _weightController = TextEditingController();
  // The unit is always "lbs"
  final String _unit = "lbs";
  // The background is always the "graph.svg" image
  final SvgPicture _background = SvgPicture.asset("assets/graph.svg");

  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  // Show a toast error message if the weight is out of range (0-350)
  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.announcement_rounded),
          SizedBox(
            width: 12.0,
          ),
          Text("Error: Weight must be between 0 and 350"),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _weight is an integer to be passed into "bubble" widget
    int _weight = 0;
    // Try-Catch block for exception when _weightController.text is not a number
    try {
      // If it is a number, we assign the int value to _weight
      _weight = int.parse(_weightController.text);
    } on FormatException {
      // Do nothing
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            myTextForms(),
            MetricsBubbleWidget(
              label: _labelController.text,
              weight: _weight,
              unit: _unit,
              background: _background,
            ),
          ],
        ),
      ),
    );
  }

  // Form for updating the MetricsBubbleWidget Label
  Widget myTextForms() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: _labelController,
            decoration: const InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0),
                child: FaIcon(FontAwesomeIcons.heartbeat),
              ),
              border: UnderlineInputBorder(),
              hintText: 'Enter the label here',
              labelText: "Enter the label here",
            ),
            // Update as changes are made to the form
            onChanged: (val) {
              setState(() {});
            },
          ),
        ),
        // Form for updating the MetricsBubbleWidget Weight
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: _weightController,
            decoration: const InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0),
                child: FaIcon(FontAwesomeIcons.dumbbell),
              ),
              border: UnderlineInputBorder(),
              hintText: 'Enter the weight here',
              labelText: "Enter the weight here",
            ),
            // Update as changes are made to the form
            onChanged: (val) {
              bool valid = false;
              // If field is empty, make value 0
              if (val == "") {
                val = "0";
              }

              //Try-Catch block to catch exceptions
              try {
                // Check if the value entered is between 0 and 350
                if (int.parse(val) >= 0 && int.parse(val) <= 350) {
                  valid = true;
                }
              } on FormatException {
                // Do nothing
              }

              if (valid) {
                // If the weight is good, update the widget
                setState(() {});
              } else {
                // Otherwise, show an error message
                _showToast();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _labelController.dispose();
    _weightController.dispose();
  }
}
