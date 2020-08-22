import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helper_widgets/empty_space.dart';

import 'e_button.dart';

showSuccessDialog(BuildContext context, String email) {
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
                    child: SvgPicture.asset("assets/svg/message_sent_icon.svg",
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
//                        const uri = 'mailto:test@mail.com';
//                        if (await canLaunch(uri)) {
//                          await launch(uri);
//                        } else {
//                          throw 'Could not launch $uri';
//                        }
                      }),
                  EmptySpace(),
                  Center(
                    child: FlatButton(
                        onPressed: () {
//                          Router.gotoNamed(Routes.LANDING, context,
//                              clearStack: true);
                        },
                        child: Text('Goto Login')),
                  )
                  /*RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Please check your email and follow the link to "),
                        TextSpan(text: "Account"),
                        TextSpan(text: " your Equilibra Account"),
                      ]),
                    )*/
                ],
              ),
            ),
          ));
}
