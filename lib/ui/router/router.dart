import 'package:auto_route/auto_route_annotations.dart';
import 'package:equilibra_mobile/ui/screens/auth/login_screen.dart';
import 'package:equilibra_mobile/ui/screens/auth/signup_screen.dart';
import 'package:equilibra_mobile/ui/screens/home/home_screen.dart';
import 'package:equilibra_mobile/ui/screens/landing_screen.dart';
import 'package:equilibra_mobile/ui/screens/splash_screen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  MaterialRoute(page: SplashScreen, initial: true),
  MaterialRoute(page: LandingScreen),
  MaterialRoute(page: LoginScreen),
  MaterialRoute(page: SignupScreen),
  MaterialRoute(page: HomeScreen),
])
class $Router {}
