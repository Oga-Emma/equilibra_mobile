import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
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
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/validators.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with UISnackBarProvider, ErrorHandler {
  var _formkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String email, password;

  bool _autoValidate = false;
  UserController userController;
//
//  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);

    return ViewModelBuilder<AuthViewModel>.reactive(
      builder: (context, model, child) {
        return AuthBackground(
            scaffoldKey: scaffoldKey,
            title: "Welcome Back",
            subtitle: "Please login to continue using Equilibra",
            child: Form(
              autovalidate: _autoValidate,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  EAuthTextField(
                      autoValidate: _autoValidate,
                      inputType: TextInputType.emailAddress,
                      validator: Validators.validateEmail(),
                      onSaved: (value) {
                        email = value.trim().replaceAll(" ", "");
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
                      password = value;
                    },
                    hintText: "Password",
                    icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                        width: 20, height: 20),
                  ),
                  EmptySpace(multiple: 2),
                  EButton(
                      loading: model.isBusy,
                      label: "Login",
                      onTap: () => login(model)),
                  EmptySpace(multiple: 2),
                  FlatButton(
                    onPressed: () => model.showResetPasswordPage(),
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
                          onTap: () => model.showSsignupPage(),
                          child: Text(
                            "Create One",
                            style: TextStyle(color: Pallet.primaryColor),
                          )),
                    ],
                  ),
                  EmptySpace(multiple: 5),
                ],
              ),
            ),
            showBackButton: false);
      },
      viewModelBuilder: () => AuthViewModel(),
    );
  }

  login(AuthViewModel model) async {
    try {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        UserDTO user = await model.login(email: email, password: password);
        userController.user = user;
        model.completeLogin(context, user);
      } else {
        showInSnackBar(context, "Please fill out all fields");
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (err) {
      showInSnackBar(context, getErrorMessage(err));
    }
  }
}
