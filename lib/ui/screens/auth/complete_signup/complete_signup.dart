import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/complete_signup_dto.dart';
import 'package:equilibra_mobile/ui/core/widgets/auth_background.dart';
import 'package:equilibra_mobile/ui/screens/auth/complete_signup/where_you_are_from.dart';
import 'package:equilibra_mobile/ui/screens/auth/complete_signup/where_you_reside.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:provider/provider.dart';

import '../auth_viewmodel.dart';

class CompleteSignupScreen extends StatefulWidget {
  @override
  _CompleteSignupScreenState createState() => _CompleteSignupScreenState();
}

CompleteSignupDTO completeSignup = CompleteSignupDTO();

class _CompleteSignupScreenState extends State<CompleteSignupScreen>
    with UISnackBarProvider, ErrorHandler {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var _current = 0;

  bool _autoValidate = false;

  initState() {
    super.initState();
  }

  AuthViewModel controller = AuthViewModel();
  @override
  Widget build(BuildContext context) {
    return AuthBackground(
        title: _current == 0
            ? "Tell us where you are from"
            : "Tell us where you reside in",
        subtitle: "Let's get you all setup",
        scaffoldKey: scaffoldKey,
        child: Container(
          margin: EdgeInsets.only(bottom: 100),
          child: IndexedStack(
            index: _current,
            children: <Widget>[
              PlaceOfOriginScreen(completeSignup, onNext: () {
                setState(() {
                  _current = 1;
                });
              }, onError: handleError),
              PlaceOfResidenceScreen(completeSignup,
                  onError: handleError, onNext: _completeSignup),
            ],
          ),
        ),
        showBackButton: true);
  }

  _completeSignup() async {
    try {
      showLoadingSnackBar(context);
      await controller.completeSignup(completeSignup.toMap());
      closeLoadingSnackBar();
      controller.showHomeScreen();
    } catch (e) {
      showInSnackBar(context, getErrorMessage(e));
    }
  }

  handleError(String error) {
    showInSnackBar(context, error);
  }
}
