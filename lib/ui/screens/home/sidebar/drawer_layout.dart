import 'package:equilibra_mobile/di/controllers/data_controller.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:stacked/stacked.dart';

import '../feed_back_dialog.dart';
import '../home_view_model.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = getParentViewModel<HomeViewModel>(context);
    return Drawer(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: SizedBox()),
              IconButton(
                  icon: Icon(
                    EvaIcons.close,
                    size: 28,
                    color: Pallet.accentColor,
                  ),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
          Expanded(
            child: Padding(
              child: Column(
                children: <Widget>[
                  SideBarItem(
                    label: "Home",
                    icon: SvgIconUtils.HOME,
                    selected: controller.currentPage == 0,
                    onTap: () {
                      Navigator.pop(context);
                      controller.currentPage = 0;
                    },
                  ),
//                  EmptySpace(),
//                  SideBarItem(
//                    label: "Notifications",
//                    icon: SvgIconUtils.NOTIFICATION,
//                    selected: controller.currentPage == 1,
//                    onTap: () {
//                      Navigator.pop(context);
//                      controller.currentPage = 1;
////                      Router.gotoNamed(Routes.NOTIFICATION, context);
//                    },
//                  ),
                  EmptySpace(),
                  SideBarItem(
                    label: "About Us",
                    icon: SvgIconUtils.ABOUT_US,
                    selected: controller.currentPage == 2,
                    onTap: () {
                      Navigator.pop(context);
                      controller.currentPage = 2;
//                      appState.selectedTab = 1;
                    },
                  ),
                  EmptySpace(),
                  SideBarItem(
                    label: "Contact Us",
                    icon: SvgIconUtils.CONTACT_US,
                    selected: controller.currentPage == 3,
                    onTap: () {
                      Navigator.pop(context);

                      controller.currentPage = 2;
//                      appState.selectedTab = 2;
                    },
                  ),
                  EmptySpace(),
                  SideBarItem(
                    label: "Feedbacks",
                    icon: SvgIconUtils.FEEDBACK,
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);

                      controller.currentPage = 0;
                      showDialog(
                          context: context,
                          builder: (context) => FeedBackDialog("email"));
                    },
                  ),
                  EmptySpace(),
                  SideBarItem(
                    label: "Settings",
                    icon: SvgIconUtils.SETTINGS,
                    selected: false,
                    onTap: () {
                      Navigator.pop(context);

                      controller.currentPage = 0;
                      controller.settingsScreen();
                    },
                  )
                ],
              ),
              padding: EdgeInsets.only(right: 40),
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              height: 1,
              color: Colors.grey[400]),
          Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              width: double.maxFinite,
              child: InkWell(
                onTap: () {
                  controller.logout();
//                  googleSignIn.signOut();
//                  appState.signout();
//                  Router.gotoNamed(Routes.LANDING, context, clearStack: true);
                },
                child: Row(
                  children: <Widget>[
                    SvgIconUtils.getSvgIcon(SvgIconUtils.LOGOUT,
                        color: Colors.red),
                    EmptySpace(multiple: 2),
                    Text("Logout", style: Theme.of(context).textTheme.subhead),
                  ],
                ),
              ),
              decoration: BoxDecoration()),
          EmptySpace()
        ],
      )),
    );
  }
}

class SideBarItem extends StatelessWidget {
  SideBarItem(
      {@required this.label,
      @required this.icon,
      @required this.onTap,
      this.selected = false});
  String icon;
  String label;
  Function() onTap;
  bool selected;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          width: double.maxFinite,
          child: Row(
            children: <Widget>[
              SvgIconUtils.getSvgIcon(icon,
                  color: selected ? Pallet.primaryColor : Colors.grey[800]),
              EmptySpace(multiple: 2),
              Text("$label", style: Theme.of(context).textTheme.subhead),
            ],
          ),
          decoration: BoxDecoration(
              color: selected ? Pallet.groupIconColor : Colors.transparent),
        ),
      ),
    );
  }
}
