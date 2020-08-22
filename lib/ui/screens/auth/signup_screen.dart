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
                        email = value;
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
                  SocialAuthButtons(google: (value) {}, facebook: (value) {}),
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

        showSuccessDialog(context, model);
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

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  showSuccessDialog(BuildContext context, AuthViewModel model) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
              content: Container(
//                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    emptySpace(multiple: 3),
                    Container(
                      child: SvgPicture.asset(
                          "assets/svg/message_sent_icon.svg",
                          height: 120),
                    ),
                    emptySpace(multiple: 3),
                    Text("A verification email has been sent to",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.grey)),
                    Text("$email", style: TextStyle(fontSize: 12.0)),
                    emptySpace(multiple: 2),
                    Text(
                        "Please check your email and follow the link to activate your Equilibra Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith()),
                    emptySpace(multiple: 3),
                    EButton(
                        label: "Open Email App",
                        onTap: () async {
                          var result = await OpenMailApp.openMailApp();

                          // If no mail apps found, show error
                          if (!result.didOpen && !result.canOpen) {
                            showNoMailAppsDialog(context);

                            // iOS: if multiple mail apps found, show dialog to select.
                            // There is no native intent/default app system in iOS so
                            // you have to do it yourself.
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return MailAppPickerDialog(
                                  mailApps: result.options,
                                );
                              },
                            );
                          }
                        }),
                    emptySpace(),
                    Center(
                      child: FlatButton(
                          onPressed: () => model.showLoginPage(),
                          child: Text('Goto Login')),
                    )
                    /*RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Please check your email and follow the link to "),
                        TextSpan(text: "Account"),
                        TextSpan(text: " your Equilibra Account"),
                      ]),
                    )*/
                  ],
                ),
              ),
            ));
  }
}
