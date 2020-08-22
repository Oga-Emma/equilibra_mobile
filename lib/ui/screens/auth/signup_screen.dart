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
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with UISnackBarProvider {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

//  var //signup.= User//signup.TO();
  var _passwordController = TextEditingController();
  var _dobController = TextEditingController();
  var _autovalidate = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

//  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
//    appState = Provider.of<AppStateProvider>(context);
    return AuthBackground(
        scaffoldKey: _scaffoldKey,
        title: "Create Account",
        subtitle: "Let's get you all setup.",
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EAuthTextField(
                  autoValidate: _autovalidate,
                  validator: Validators.validateString(),
                  onSaved: (value) {
//                        //signup.fullName = value;
                  },
                  hintText: "Full Name",
                  icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                      width: 20, height: 20)),
              EmptySpace(multiple: 2),
              EAuthTextField(
                  autoValidate: _autovalidate,
                  validator: Validators.validateString(),
                  onSaved: (value) {
//                        //signup.username = value;
                  },
                  hintText: "Username",
                  icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                      width: 20, height: 20)),
              EmptySpace(multiple: 2),
              EAuthTextField(
                  autoValidate: _autovalidate,
                  validator: Validators.validateEmail(),
                  onSaved: (value) {
                    //signup.email = value;
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
                autoValidate: _autovalidate,
                controller: _passwordController,
                validator: Validators.validateString(),
                onSaved: (value) {
                  //signup.password = value;
                },
                hintText: "Password",
                icon: SvgIconUtils.getSvgIcon(SvgIconUtils.LOCK,
                    width: 20, height: 20),
              ),
              EmptySpace(multiple: 2),
              EAuthTextField(
                obscureText: true,
                autoValidate: _autovalidate,
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
              EmptySpace(multiple: 2),
              EButton(label: "SIGN UP", onTap: () {}),
              /*EButton(label: "Next", onTap: (){
                    Router.gotoWidget(PlaceOfOriginScreen(), context);
                  }),*/
              EmptySpace(multiple: 2),
              SocialAuthButtons(google: (value) {}, facebook: (value) {}),
              EmptySpace(multiple: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an account? "),
                  EmptySpace(),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: Pallet.primaryColor),
                      )),
                ],
              ),
              EmptySpace(multiple: 2),
            ],
          ),
        ),
        showBackButton: true);
  }

  var dateFormat = DateFormat("yyyy - MM - dd");
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1990, 1), //selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      _dobController.text = dateFormat.format(picked);
    setState(() {
      selectedDate = picked;
    });
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
