import 'package:equilibra_mobile/ui/screens/home/home_view_model.dart';
import 'package:equilibra_mobile/ui/screens/home/setting/settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../home_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.nonReactive(
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Settings"),
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios)),
              ),
              body: Container(
                padding: EdgeInsets.all(24.0),
                child: ListView(
                  children: <Widget>[
                    getHeading(context, "Account"),
                    item("Edit profile", model.editProfile),
                    item("Change password", model.changePassword),
                    EmptySpace(multiple: 5),
                    getHeading(context, "Notifications"),
                    EmptySpace(multiple: 0.5),
//              doNotDisturb(),
                    DoNotDisturbSwitch(),
//              EmptySpace(),
//              groupNotification("Group-specific notifications", () {}),
                    EmptySpace(multiple: 5),
                    getHeading(context, "State of Residence"),
                    item("Change State of Residence",
                        model.changeStateOfResidence),
                    EmptySpace(multiple: 5),
                    getHeading(context, "Diaspora"),
                    item("Change Diaspora", model.changeDiaspora),
                    EmptySpace(multiple: 5),
                    getHeading(context, "More"),
                    item("Privacy & Licenses", () {}),
                    item("Send Feedbacks", () {}),
                    EmptySpace(multiple: 5),
                    Divider(),
                    SizedBox(
                      child: InkWell(
                        onTap: () => HomeViewModel().logout(),
                        child: Text(
                          "Signout of Equilibra",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
        viewModelBuilder: () => SettingsViewModel());
  }

  Widget getHeading(BuildContext context, String title) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(
              "assets/svg/person_avater.svg",
              height: 20,
              color: Colors.black,
            ),
            EmptySpace(multiple: 2),
            Text(
              "$title",
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
            ),
          ],
        ),
        Divider()
      ],
    );
  }

  Widget doNotDisturb() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          "Do not disturb",
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        )),
        CupertinoSwitch(value: false, onChanged: (changed) {})
      ],
    );
  }

  Widget item(String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              "$title",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            )),
            Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }

  Widget groupNotification(String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            "$title",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          )),
          Icon(Icons.arrow_forward_ios, size: 16)
        ],
      ),
    );
  }
}
