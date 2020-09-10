import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/auth_background.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_auth_textfield.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:equilibra_mobile/ui/screens/auth/social_auth/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/validators.dart';
import 'package:intl/intl.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';

import 'auth_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with UISnackBarProvider, ErrorHandler {
  var _formkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var _passwordController = TextEditingController();
  var _dobController = TextEditingController();
  var _autovalidate = false;

  var fullName, userName, email, birthMonth, birthYear, password;

  @override
  void dispose() {
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      builder: (context, model, child) {
        return AuthBackground(
            scaffoldKey: scaffoldKey,
            title: "Create Account",
            subtitle: "Let's get you all setup.",
            child: Form(
              autovalidate: _autovalidate,
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EAuthTextField(
                      validator: Validators.validateString(),
                      onSaved: (value) {
//                        //signup.fullName = value;
                        fullName = value;
                      },
                      hintText: "Full Name",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                          width: 20, height: 20)),
                  EmptySpace(multiple: 2),
                  EAuthTextField(
                      validator: Validators.validateString(),
                      onSaved: (value) {
//                        //signup.username = value;
                        userName = value;
                      },
                      hintText: "Username",
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                          width: 20, height: 20)),
                  EmptySpace(multiple: 2),
                  EAuthTextField(
                      validator: Validators.validateEmail(),
                      onSaved: (value) {
                        //signup.email = value;
                        email = value.trim().replaceAll(" ", "");
                      },
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                          width: 20, height: 20)),
                  EmptySpace(multiple: 2),
                  GestureDetector(
                      onTap: () => _selectDate(),
                      child: AbsorbPointer(
                        child: EAuthTextField(
                          controller: _dobController,
                          validator: Validators.validateString(),
                          onSaved: (value) {
                            //signup.dob = value;
                          },
                          hintText: "Date of Birth",
                          icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                              width: 20, height: 20),
                        ),
                      )),
                  EmptySpace(multiple: 2),
                  EAuthTextField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: Validators.validateString(),
                    onSaved: (value) {
                      //signup.password = value;
                      password = value;
                    },
                    hintText: "Password",
                    icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                        width: 20, height: 20),
                  ),
                  EmptySpace(multiple: 2),
                  EAuthTextField(
                    obscureText: true,
                    validator: (value) {
                      if (value == _passwordController.text) {
                        return null;
                      }
                      return "Password do not match";
                    },
                    hintText: "Confirm Password",
                    icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                        width: 20, height: 20),
                    isLastTextField: true,
                  ),
                  EmptySpace(multiple: 4),
                  EButton(
                      loading: model.isBusy,
                      label: "Sign Up",
                      onTap: model.isBusy ? () {} : () => createAccount(model)),
                  /*EButton(label: "Next", onTap: (){
                    Router.gotoWidget(PlaceOfOriginScreen(), context);
                  }),*/
                  EmptySpace(multiple: 4),
                  SocialAuthButtons(),
                  EmptySpace(multiple: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Have an account? "),
                      EmptySpace(),
                      InkWell(
                          onTap: () => model.showLoginPage(),
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Pallet.primaryColor),
                          )),
                    ],
                  ),
                  EmptySpace(multiple: 4),
                ],
              ),
            ),
            showBackButton: true);
      },
      viewModelBuilder: () => AuthViewModel(),
    );
  }

  var dateFormat = DateFormat("yyyy - MM - dd");
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1990, 1), //selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) birthMonth = picked.month;
    birthYear = picked.year;
    _dobController.text = dateFormat.format(picked);
    setState(() {
      selectedDate = picked;
    });
  }

  createAccount(AuthViewModel model) async {
    try {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        await model.createAccount(
            fullName: fullName,
            username: userName,
            email: email,
            birthYear: birthYear,
            birthMonth: birthMonth,
            password: password);

        model.showSuccessDialog(context, model, email);
      } else {
        showInSnackBar(context, "Please fill out all fields");
        setState(() {
          _autovalidate = true;
        });
      }
    } catch (err) {
      showInSnackBar(context, getErrorMessage(err));
    }
  }
}
