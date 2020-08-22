import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  var _navigation = getIt<NavigationService>();
  var _userRepo = getIt<UserRepo>();
  var _localCache = getIt<LocalCache>();

  showLandingPage() {
    _navigation.clearStackAndShow(Routes.landingScreen);
  }

  showLoginPage() {
    _navigation.clearStackAndShow(Routes.loginScreen);
  }

  showSsignupPage() {
    _navigation.navigateTo(Routes.signupScreen);
  }

  showResetPasswordPage() {
    _navigation.navigateTo(Routes.resetPasswordScreen);
  }

  showHomeScreen() {
    _navigation.clearStackAndShow(Routes.homeScreen);
  }

  showCompleteProfileScreen() {
    _navigation.navigateTo(Routes.completeSignupScreen);
  }

  Future createAccount(
      {birthMonth,
      birthYear,
      currentCountry,
      email,
      fullName,
      password,
      username}) async {
    try {
      setBusy(true);
      await _userRepo.createAccount(
          birthMonth: birthMonth,
          birthYear: birthYear,
          email: email,
          currentCountry: currentCountry,
          fullName: fullName,
          password: password,
          username: username);
    } catch (err) {
      setBusy(false);
      throw err;
    }

    setBusy(false);
  }

  Future login({email, password}) async {
    try {
      setBusy(true);
      var user = await _userRepo.login(email: email, password: password);
      setBusy(false);
      return user;
    } catch (err) {
      setBusy(false);
      throw err;
    }

    setBusy(false);
  }

  Future sendVerificationMail(email) async {
    try {
      setBusy(true);
//      await _userRepo.login(email: email, password: password);
    } catch (err) {
      setBusy(false);
      throw err;
    }

    setBusy(false);
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

  showSuccessDialog(BuildContext context, AuthViewModel model, String email,
      {bool formLogin = false}) {
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
                    Text("A verification email has been sent to",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.grey)),
                    Text("$email", style: TextStyle(fontSize: 12.0)),
                    EmptySpace(multiple: 2),
                    Text(
                        "Please check your email and follow the link to activate your Equilibra Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith()),
                    EmptySpace(multiple: 3),
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
                    EmptySpace(),
                    Center(
                      child: isBusy
                          ? LoadingSpinner()
                          : formLogin
                              ? FlatButton(
                                  onPressed: () => sendVerificationMail(email),
                                  child: Text('Resend email'))
                              : FlatButton(
                                  onPressed: () => model.showLoginPage(),
                                  child: Text('Goto Login')),
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> completeLogin(BuildContext context, UserDTO user) async {
    await Future.delayed(Duration.zero);
    if (user.suspended) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Account suspended!"),
                content: Text(
                    "This account has been suspended, please contact the admin for further information"),
              ));
      return;
    }

    if (user.confirmed) {
      if (user.signupStatus) {
        showHomeScreen();
      } else {
        showCompleteProfileScreen();
      }
    } else {
      showSuccessDialog(context, this, user.email, formLogin: true);
    }
  }

  Future<UserDTO> getUser() async {
    try {
      return await _localCache.getUser();
    } catch (err) {
      showLandingPage();
    }
  }
}

class TitleId {
  String name;
  String id;

  TitleId.fromMap(Map<String, dynamic> data)
      : id = data['id'] ?? data['_id'],
        name = data['name'];
}
