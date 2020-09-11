import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper_widgets/custom_snackbar/ui_snackbar.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';

import '../auth_viewmodel.dart';

class SocialAuthButtons extends StatefulWidget {
  @override
  _SocialAuthButtonsState createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons>
    with UISnackBarProvider, ErrorHandler {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  UserController userController;

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);
    AuthViewModel model = Provider.of<AuthViewModel>(context);
    return Column(
      children: <Widget>[
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: InkWell(
            onTap: () {
              _facebook(model);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgIconUtils.getSvgIcon(SvgIconUtils.FACEBOOK,
                    color: Color(0xFF385C8E), width: 24, height: 24),
                Text(
                  "Sign in with Facebook",
                  style: TextStyle(fontSize: 16.0, color: Color(0xFF385C8E)),
                ),
                SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
          decoration:
              BoxDecoration(color: Color(0xFFE2E6EB), borderRadius: radius),
        ),
        EmptySpace(multiple: 2),
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: InkWell(
            onTap: () => _googleSignin(model),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SvgIconUtils.getSvgIcon(SvgIconUtils.GOOGLE_PLUS,
                    color: Color(0xFFDD4C41), width: 24, height: 24),
                Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFDD4C41)),
                ),
                SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
          decoration:
              BoxDecoration(color: Color(0xFFF5E8EA), borderRadius: radius),
        ),
      ],
    );
  }

  Future<void> _facebook(AuthViewModel model) async {
//    // appId = 2419999161601918

    model.setBusy(true);
    showLoadingSnackBar(context);
    try {
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logIn(['email', 'public_profile']);

//    print("Facebook Error => ${result.errorMessage}");
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          _socialLogin(model, result.accessToken.token, false);
//        _sendTokenToServer(result.accessToken.token);
//        _showLoggedInUI();
          break;
        case FacebookLoginStatus.cancelledByUser:
          showInSnackBar(context, "Canceled by user");
          break;
        case FacebookLoginStatus.error:
          showInSnackBar(context, result.errorMessage);
          break;

        default:
          {
            showInSnackBar(context, "Signin failed, please try again");
          }
      }
    } catch (err) {
      showInSnackBar(context, getErrorMessage(err));
    }
    model.setBusy(false);
    closeLoadingSnackBar();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<void> _googleSignin(AuthViewModel model) async {
    try {
      await _googleSignIn.signOut();
      var account = await _googleSignIn.signIn();
      var auth = await account.authentication;
      var token = auth.accessToken;

//      print("TOKEN => $token");
      await _socialLogin(model, token, true);
    } catch (error) {
      showErrorToast(getErrorMessage(error));
//      print(error);
    }
  }

  Future<void> _socialLogin(
      AuthViewModel model, String token, bool isGoogle) async {
    try {
      UserDTO user = await userController.socialAuth(token, isGoogle);
      userController.user = user;
      model.completeLogin(context, user);
    } catch (err) {
      print(err);
      showInSnackBar(context, getErrorMessage(err));
    }
  }
}
