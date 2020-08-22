import 'package:equilibra_mobile/ui/screens/auth/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var overlay =
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlay, child: Scaffold(body: LandingScreen()));
  }
}
