import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/auth_background.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_auth_textfield.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:equilibra_mobile/ui/screens/auth/auth_viewmodel.dart';
import 'package:equilibra_mobile/ui/screens/auth/social_auth/social_auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:helper_widgets/validators.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with UISnackBarProvider, ErrorHandler {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();

  bool _autoValidate = false;
  UserController userController;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);

    return ViewModelBuilder<UserController>.reactive(
      disposeViewModel: false,
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
                    controller: emailController,
                    autoValidate: _autoValidate,
                    inputType: TextInputType.emailAddress,
                    validator: Validators.validateEmail(),
                    hintText: "Email Address",
                    icon: SvgIconUtils.getSvgIcon(SvgIconUtils.PERSON_AVATER,
                        width: 20, height: 20)),
                EmptySpace(multiple: 4),
                EButton(
                    loading: model.isBusy,
                    label: "Request password reset",
                    onTap: () async {
                      try {
                        var validate =
                            Validators.validateEmail()(emailController.text);

                        if (StringUtils.isNotEmpty(validate)) {
                          showInSnackBar(context, validate);
                          return;
                        }

                        await model.forgotPassword(emailController.text);
                        showSuccessDialog(emailController.text);
                      } catch (err) {
                        showInSnackBar(context, getErrorMessage(err));
                      }
                    }),
                EmptySpace(multiple: 2),
                Center(
                  child: FlatButton(
                    onPressed: userController.isBusy
                        ? () {}
                        : () => Navigator.pop(context),
                    child: Text("Remember your password? Sign In",
                        style: TextStyle(color: Pallet.primaryColor)),
                  ),
                ),
                EmptySpace(multiple: 5),
              ],
            ),
            showBackButton: true);
      },
      viewModelBuilder: () => userController,
    );
  }

  showSuccessDialog(String email) {
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
                    EmptySpace(multiple: 3),
                    Container(
                      child: SvgPicture.asset(
                          "assets/svg/message_sent_icon.svg",
                          height: 120),
                    ),
                    EmptySpace(multiple: 3),
                    Text("A password reset mail has been sent to",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.grey)),
                    Text("$email", style: TextStyle(fontSize: 12.0)),
                    EmptySpace(multiple: 2),
                    Text(
                        "Please check your email and follow the link to reset your Equilibra Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith()),
                    EmptySpace(multiple: 3),
                    Center(
                      child: FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close')),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
