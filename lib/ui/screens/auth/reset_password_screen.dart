import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/auth_background.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_auth_textfield.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:equilibra_mobile/ui/screens/auth/auth_viewmodel.dart';
import 'package:equilibra_mobile/ui/screens/auth/social_auth/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/validators.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with UISnackBarProvider {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email = "";
  String _password = "";

  bool _autoValidate = false;
//
//  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
//    appState = Provider.of<AppStateProvider>(context);

    return ViewModelBuilder<AuthViewModel>.reactive(
      builder: (context, model, child) {
        return AuthBackground(
            scaffoldKey: _scaffoldKey,
            title: "Recover your password",
            subtitle: "Please enter the email registered on your account",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "We'll Email you a link to change your password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
                ),
                EmptySpace(multiple: 2),
                EAuthTextField(
                    autoValidate: _autoValidate,
                    inputType: TextInputType.emailAddress,
                    validator: Validators.validateEmail(),
                    onSaved: (value) {
                      _email = value;
                    },
                    hintText: "Email Address",
                    icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                        width: 20, height: 20)),
                EmptySpace(multiple: 4),
                EButton(label: "Request password reset", onTap: () {}),
                EmptySpace(multiple: 2),
                Center(
                  child: FlatButton(
                    onPressed: () => model.showLoginPage(),
                    child: Text("Remember your password? Sign In",
                        style: TextStyle(color: Pallet.primaryColor)),
                  ),
                ),
                EmptySpace(multiple: 5),
              ],
            ),
            showBackButton: true);
      },
      viewModelBuilder: () => AuthViewModel(),
    );
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
