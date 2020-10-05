import 'package:equilibra_mobile/di/controllers/data_controller.dart';
import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/ui/screens/auth/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:stacked/stacked.dart';

import 'auth/auth_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var overlay =
        SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

    return ViewModelBuilder<AuthViewModel>.nonReactive(
        builder: (context, model, child) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlay,
              child: Scaffold(
                  body: FutureBuilder(
                future: model.getUser(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // print(snapshot.data);
                    Provider.of<UserController>(context).user = snapshot.data;
                    model.completeLogin(context, snapshot.data);
                  }

                  return LoadingSpinner();
                },
              )));
        },
        viewModelBuilder: () => AuthViewModel());
  }
}
