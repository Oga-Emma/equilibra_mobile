import 'package:flutter/material.dart';
import 'package:helper_widgets/loading_spinner.dart';

showLoadingDialog(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (context) => Center(child: LoadingSpinner()));
