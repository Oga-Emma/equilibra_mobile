import 'package:flutter/material.dart';

Widget emptySpace({double multiple = 1}) {
  var size = multiple * 8;
  return SizedBox(height: size, width: size);
}

BorderRadius get radius => BorderRadius.circular(2.0);
