import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  var _navigation = getIt<NavigationService>();
  var _userRepo = getIt<UserRepo>();

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
}
