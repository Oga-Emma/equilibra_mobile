import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/auth_background.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_auth_textfield.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:equilibra_mobile/ui/screens/auth/social_auth/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with UISnackBarProvider {
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

    return AuthBackground(
        scaffoldKey: _scaffoldKey,
        title: "Welcome Back",
        subtitle: "Please login to continue using Equilibra",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
            EmptySpace(multiple: 2),
            EAuthTextField(
              autoValidate: _autoValidate,
              obscureText: true,
              validator: Validators.validatePlainPass(),
              onSaved: (value) {
                _password = value;
              },
              hintText: "Password",
              icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                  width: 20, height: 20),
            ),
            EmptySpace(multiple: 2),
            EButton(label: "Login", onTap: () {}),
            EmptySpace(multiple: 2),
            FlatButton(
              onPressed: () {},
              child: Text("Forgot my password?",
                  style: TextStyle(color: Pallet.primaryColor)),
            ),
            EmptySpace(multiple: 2),
            SocialAuthButtons(google: (value) {}, facebook: (value) {}),
            EmptySpace(multiple: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account? "),
                EmptySpace(),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "Create One",
                      style: TextStyle(color: Pallet.primaryColor),
                    )),
              ],
            ),
            EmptySpace(multiple: 5),
          ],
        ),
        showBackButton: false);
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
