import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Center(child: CircularProgressIndicator()));