import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helper_widgets/empty_space.dart';

import 'helper.dart';

class AuthBackground extends StatelessWidget {
  AuthBackground(
      {@required this.child,
      @required this.scaffoldKey,
      this.showBackButton = false,
      this.onBackPressed,
      this.title,
      this.subtitle});

  final Widget child;
  final bool showBackButton;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function() onBackPressed;
  final title;
  final subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Pallet.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            SizedBox(
              width: double.maxFinite,
              child: Image.asset("assets/img/auth_screens_bg.png",
                  fit: BoxFit.cover),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  showBackButton
                      ? EmptySpace(multiple: 2)
                      : EmptySpace(multiple: 6),
                  showBackButton
                      ? IconButton(
                          icon: SvgPicture.asset(
                              "assets/svg/ic_auth_back_arrow.svg"),
                          onPressed: () {
                            if (onBackPressed == null) {
                              Navigator.pop(context);
                            } else {
                              onBackPressed();
                            }
                          })
                      : SizedBox(),
                  Center(
                    child: Text(
                      "theEquilibra",
                      style: Theme.of(context).textTheme.display1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 28),
                    ),
                  ),
                  EmptySpace(multiple: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(borderRadius: radius),
                            elevation: 1.0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 24.0, right: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  EmptySpace(),
                                  Text("$title",
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              fontWeight: FontWeight.w400)),
                                  EmptySpace(),
                                  Text(
                                    "$subtitle",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  EmptySpace(multiple: 3),
                                  child
                                ],
                              ),
                            ),
                          ),
                          EmptySpace.v3(),
                          Center(
                              child: Text(
                            "© theEquilibra.com. All Rights Reserved.",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
