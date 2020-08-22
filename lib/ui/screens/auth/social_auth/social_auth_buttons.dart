import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class SocialAuthButtons extends StatelessWidget {
  SocialAuthButtons({this.google, this.facebook});
  Function(String) google;
  Function(String) facebook;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: InkWell(
            onTap: () {
              _facebook();
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
            onTap: _googleSignin,
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

  Future<void> _facebook() async {
//    // appId = 2419999161601918
//    final facebookLogin = FacebookLogin();
//    final result = await facebookLogin
//        .logInWithReadPermissions(['email', 'public_profile']);
//
//    print("Facebook Error => ${result.errorMessage}");
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        facebook(result.accessToken.token);
////        _sendTokenToServer(result.accessToken.token);
////        _showLoggedInUI();
//        break;
//      case FacebookLoginStatus.cancelledByUser:
////        _showCancelledMessage();
//        break;
//      case FacebookLoginStatus.error:
////        _showErrorOnUI(result.errorMessage);
//        break;
//    }
  }

  Future<void> _googleSignin() async {
//    try {
//      var account = await googleSignIn.signIn();
//      var auth = await account.authentication;
//      var token = auth.accessToken;
//
//      print("TOKEN => $token");
//      google(token);
//    } catch (error) {
//      print(error);
//    }
  }
}
