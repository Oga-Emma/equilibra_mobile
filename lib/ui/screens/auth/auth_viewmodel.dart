import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  var _navigation = getIt<NavigationService>();

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
}
