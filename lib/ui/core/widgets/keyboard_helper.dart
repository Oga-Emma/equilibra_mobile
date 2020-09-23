import 'package:flutter/cupertino.dart';

hideKeyboard(BuildContext context) {
  if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      return true;
    }
  }
  return false;
}
