import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/res/pallet.dart';

class LandingScreen extends StatelessWidget {
  var _navigationService = getIt<NavigationService>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Image.asset(
            "assets/img/landing_bg.png",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "People's\nParliament!",
                style: textTheme.display1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              EmptySpace(multiple: 3),
              Text(
                  "Forum for the people to discuss issues of common interest in the community, constructively and engage with public institutions and officers",
                  style: textTheme.headline.copyWith(
                      fontSize: 18, height: 1.1, color: Colors.white)),
              EmptySpace(multiple: 5),
              Column(
                children: <Widget>[
                  SizedBox(
                      height: 56,
                      width: double.maxFinite,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          _navigationService.navigateTo(Routes.signupScreen);
                        },
                        color: Pallet.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              EmptySpace(multiple: 2),
                              Expanded(
                                  child: Text(
                                "Register",
                                style: textTheme.headline.copyWith(
                                    fontSize: 18, color: Colors.white),
                              )),
                              Container(
                                color: Pallet.accentColor,
                                height: double.maxFinite,
                                width: 40,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  EmptySpace(multiple: 3),
                  SizedBox(
                      height: 56,
                      width: double.maxFinite,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          _navigationService.navigateTo(Routes.loginScreen);
                        },
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              EmptySpace(multiple: 2),
                              Expanded(
                                  child: Text(
                                "Login",
                                style: textTheme.headline.copyWith(
                                    fontSize: 18, color: Pallet.primaryColor),
                              )),
                              Container(
                                color: Pallet.primaryColor,
                                height: double.maxFinite,
                                width: 40,
                                child: Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
