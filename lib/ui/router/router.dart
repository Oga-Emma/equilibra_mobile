import 'package:auto_route/auto_route_annotations.dart';
import 'package:equilibra_mobile/ui/screens/auth/complete_signup/complete_signup.dart';
import 'package:equilibra_mobile/ui/screens/auth/login_screen.dart';
import 'package:equilibra_mobile/ui/screens/auth/reset_password_screen.dart';
import 'package:equilibra_mobile/ui/screens/auth/signup_screen.dart';
import 'package:equilibra_mobile/ui/screens/home/home_screen.dart';
import 'package:equilibra_mobile/ui/screens/auth/landing_screen.dart';
import 'package:equilibra_mobile/ui/screens/splash_screen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: LandingScreen),
  MaterialRoute(page: LoginScreen),
  MaterialRoute(page: ResetPasswordScreen),
  MaterialRoute(page: SignupScreen),
  MaterialRoute(page: HomeScreen),
  MaterialRoute(page: CompleteSignupScreen),
])
class $Router {}
