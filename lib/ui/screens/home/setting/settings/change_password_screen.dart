import 'dart:io';

import 'package:equilibra_mobile/input_validators.dart';
import 'package:equilibra_mobile/ui/core/widgets/custom_dialogs.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with UISnackBarProvider {
  var _formkey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  File image;
  bool _autoValidate = false;
  String currentPassword = "";
  String newPassword = "";

  var passwordController = TextEditingController();

  dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Change Password"),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: ListView(
              children: <Widget>[
                EFormTextField(
                    autoValidate: _autoValidate,
                    labelText: "Current Password",
                    isEnabled: true,
                    validator: InputValidators.validateString,
                    obscureText: true,
                    onSaved: (value) {
                      currentPassword = value;
                    }),
                EmptySpace(multiple: 2),
                EFormTextField(
                  autoValidate: _autoValidate,
                  controller: passwordController,
                  labelText: "New password",
                  validator: InputValidators.validateString,
                  obscureText: true,
                  isEnabled: true,
                  onSaved: (value) {
                    newPassword = value;
                  },
                ),
                EmptySpace(multiple: 2),
                EFormTextField(
                  autoValidate: _autoValidate,
                  labelText: "Confirm New Password",
                  obscureText: true,
                  isEnabled: true,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value != passwordController.text) {
                      return "Password do not match";
                    }
                    return null;
                  },
                ),
                EmptySpace(multiple: 3),
                EButton(label: "Update Password", onTap: updatePassword),
              ],
            ),
          ),
        ));
  }

  updatePassword() async {
//    if (_formkey.currentState.validate()) {
//      _formkey.currentState.save();
//
//      showLoadingSnackBar();
//      try {
//        print("Starting");
//
////        GraphQLConfigurationWithAuth.token = appState.token;
//        GraphQLClient _client = graphQLConfiguration.clientToQuery();
//        MutationOptions query = MutationOptions(
//            context: <String, dynamic>{
//              'headers': <String, String>{
//                'Authorization': 'Bearer ${appState.token}',
//              },
//            },
//            document: AuthQueryMutation.updatePassword(),
//            variables: {
//              "passwordInput": {
//                "currentPassword": currentPassword,
//                "newPassword": newPassword
//              },
//            });
//
//        var result = await _client.mutate(query);
//
//        if (result.hasException) {
//          print("Errors => ${result.exception.toString()}");
//          showInSnackBar("${result.exception.toString()}");
//        } else {
////          var user = UserDTO.fromMap(result.data.data["login"]);
////          appState.user = user;
////          Router.gotoWidget(HomeScreen(), context, clearStack: true);
////          appState.save(user);
//          showInSnackBar("Password updated");
//
////          print("after creating user => ${user.toMap()}");
//        }
//      } catch (e) {
//        print(e);
//        showInSnackBar("Error");
//      }
//    } else {
//      showInSnackBar("Please fix the errors in red");
//      setState(() {
//        _autoValidate = true;
//      });
//    }
  }

  Future _selectImage() async {
    File file = await showChooserDialog(context);
    if (file != null) {
      image = file;
      setState(() {});
    }
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
