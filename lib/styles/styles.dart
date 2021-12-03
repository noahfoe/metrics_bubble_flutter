import 'package:flutter/material.dart';

const bubbleDiameter = 272;

const bubbleBoxDecoration = BoxDecoration(
  color: Color(0xff53a99a),
  shape: BoxShape.circle,
  boxShadow: [
    BoxShadow(
      offset: Offset(0, 27),
      blurRadius: 33,
      color: Color(0x3827ae96),
    )
  ],
);

const labelTextStyle = TextStyle(
  fontFamily: 'Helvetica',
  fontWeight: FontWeight.bold,
  fontSize: 19,
  color: Colors.white,
);

const weightTextStyle = TextStyle(
  fontFamily: 'League Gothic',
  fontSize: 127,
  color: Colors.white,
);

const unitTextStyle = TextStyle(
  fontFamily: 'League Gothic',
  fontSize: 38,
  color: Color(0x80ffffff),
);
