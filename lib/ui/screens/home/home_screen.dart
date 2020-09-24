import 'dart:io';

import 'package:equilibra_mobile/di/controllers/room_controller.dart';
import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/home_grid_items.dart';
import 'package:equilibra_mobile/ui/core/widgets/home_screen_toolbar.dart';
import 'package:equilibra_mobile/ui/screens/home/home_view_model.dart';
import 'package:equilibra_mobile/ui/screens/home/sidebar/drawer_layout.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:stacked/stacked.dart';

import 'about_contact.dart';
import 'feed_back_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var federal = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
//    print("onBackgroundMessage $message");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
//      print("MESSAGE $data");
//    showOverlayMessage(data);
//      handleNotification(data);
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("MESSAGE $notification");
//    showOverlayMessage(data);
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    setupFcm();
    super.initState();
  }

  UserController controller;
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<UserController>(context, listen: false);
    var children = <Widget>[
      HomePage(_scaffoldKey),
      AboutContact(_scaffoldKey, isAbout: true),
      AboutContact(_scaffoldKey),
    ];

    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, HomeViewModel model, child) {
          return Scaffold(
              key: _scaffoldKey,
              drawer: DrawerLayout(),
              body: Container(child: children[model.currentPage]));
        },
        viewModelBuilder: () => HomeViewModel(),
        disposeViewModel: false);
  }

  void setupFcm() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      //print("Settings registered: $settings");
    });

    //addMobileToken(mobileToken: String!): user
    _firebaseMessaging.configure(
      onBackgroundMessage:
          Platform.isIOS ? null : _HomeScreenState.myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        handleNotification(message);

//        _showItemDialog(messsage);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

//        navigateToPage(message);
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

//        navigateToPage(message);
//        _navigateToItemDetail(message);
      },
    );

    _firebaseMessaging.getToken().then((String token) async {
      print(token);
      if (token != null) {
        controller.updateFCMToken(token);
      }
    });
  }

  _sendTokenToServer(String fcmToken) async {
    try {
//        LocalStorage.saveFCMToken(fcmToken);
    } catch (e) {
      //print("Error => $e");
    }
  }

  Future<void> handleNotification(Map<String, dynamic> data) async {
////    print(data['data']['author']);
////    print('room => ${appState.currentRoom}');
//    if (data == null || data['data'] == null || data['data']['room'] == null)
//      return;
//
//    var roomDoc = json.decode(data['data']['room']);
//
//    if (appState.currentRoom != null &&
//        roomDoc != null &&
//        roomDoc['roomId'] == appState.currentRoom) return;
//
//    if (data['data']['author'] == user.id) return;
//    showOverlayMessage(data, fetch: (bool fetch) async {
//      if (fetch) {
//        navigateToPage(data);
//      }
//    });
  }
}

class HomePage extends StatelessWidget {
  HomePage(this.scaffoldKey);
  GlobalKey<ScaffoldState> scaffoldKey;
  UserProfileDTO user;

  UserController controller;
  RoomController roomController;
  @override
  Widget build(BuildContext context) {
    // print("home");
    makeHeader(String headerText) {
      return SliverToBoxAdapter(
          child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 18.0, top: 32.0, bottom: 16.0),
        child: Text(headerText, style: Theme.of(context).textTheme.subtitle),
      ));
    }

    controller = Provider.of<UserController>(context);
    roomController = Provider.of<RoomController>(context);
    roomController.setupSocket();
    return StreamBuilder<UserProfileDTO>(
        stream: controller.fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;

            return ViewModelBuilder<HomeViewModel>.reactive(
                builder: (context, model, child) {
                  return Scaffold(
                      appBar: EAppBar(onLeadingPressed: () {
                        scaffoldKey.currentState.openDrawer();
                      }),
                      body: StreamBuilder<UserProfileDTO>(
                          stream: controller.fetchProfile(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              user = snapshot.data;

                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverToBoxAdapter(
                                      child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      children: <Widget>[
                                        DoNotDisturbSwitch(),
                                        Material(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              bottomLeft: Radius.circular(4.0)),
                                          color: Pallet.primaryColor,
                                          child: InkWell(
                                            onTap: () {
                                              model.getVentTheSteam();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                          "Vent the Steam",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white))),
                                                  Icon(EvaIcons.arrowIosForward,
                                                      color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  makeHeader('FEDERAL'),
                                  SliverToBoxAdapter(
                                    child: organizeGrid(
                                      children: [
                                        GroupsGridItem(
                                            icon: SvgIconUtils
                                                .JUDICIARY_GROUP_ICON,
//                                  isSelected: false,
                                            group: RoomGroupDTO("Federal",
                                                RoomType.COURT, "Judiciary", 0,
                                                description1:
                                                    "The Supreme Court",
                                                description2:
                                                    "Courts of Appeal",
                                                isFederal: true)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "Federal",
                                                RoomType.MINISTRY,
                                                "Executive",
                                                0,
                                                description1:
                                                    "Office of the president",
                                                description2:
                                                    "Federal Ministries",
                                                isFederal: true)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO("Federal",
                                                RoomType.SENATE, "Senate", 0,
                                                description1: "The Senate",
                                                description2:
                                                    "Senatorial Districts",
                                                isFederal: true)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "Federal",
                                                RoomType
                                                    .HOUSE_OF_REPRESENTATIVE,
                                                "House of Reps.",
                                                0,
                                                description1:
                                                    "The House of Representatives",
                                                description2:
                                                    "Federal Constituencies",
                                                isFederal: true)),
                                      ],
                                    ),
                                  ),
                                  makeHeader(
                                      '${user.stateOfOrigin.name} - ORIGIN'
                                          .toUpperCase()),
                                  SliverToBoxAdapter(
                                    child: organizeGrid(
                                      children: [
                                        GroupsGridItem(
                                            icon: SvgIconUtils
                                                .JUDICIARY_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfOrigin.name}",
                                                RoomType.COURT,
                                                "Judiciary",
                                                0,
                                                isOrigin: true,
                                                description1:
                                                    "Sate High Courts",
                                                description2:
                                                    "Customary Courts",
                                                roomId: user.stateOfOrigin.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfOrigin.name}",
                                                RoomType.MINISTRY,
                                                "Executive",
                                                0,
                                                description1:
                                                    "Office of the Governor",
                                                description2:
                                                    "State Ministries",
                                                isOrigin: true,
                                                roomId: user.stateOfOrigin.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfOrigin.name}",
                                                RoomType.HOUSE_OF_ASSEMBLY,
                                                "House of Assem.",
                                                0,
                                                isOrigin: true,
                                                description1:
                                                    "House of Assembly",
                                                description2:
                                                    "State Constituencies",
                                                roomId: user.stateOfOrigin.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
//                      loading: '${user.localGovtOfOrigin.name}'.contains('LGA'),
                                            group: RoomGroupDTO(
                                                "${user.stateOfOrigin.name}",
                                                RoomType.LGA,
                                                "${user.localGovtOfOrigin.name}",
                                                0,
                                                isOrigin: true,
                                                description1:
                                                    "Origin Local Government",
                                                roomId: user.stateOfOrigin.id)),
                                      ],
                                    ),
                                  ),
                                  makeHeader(
                                      "${user.stateOfResidence.name}  - RESIDENCE"
                                          .toUpperCase()),
                                  SliverToBoxAdapter(
                                    child: organizeGrid(
                                      children: [
                                        GroupsGridItem(
                                            icon: SvgIconUtils
                                                .JUDICIARY_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfResidence.name}",
                                                RoomType.COURT,
                                                "Judiciary",
                                                0,
                                                description1:
                                                    "Sate High Courts",
                                                description2:
                                                    "Customary Courts",
                                                roomId:
                                                    user.stateOfResidence.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfResidence.name}",
                                                RoomType.MINISTRY,
                                                "Executive",
                                                0,
                                                description1:
                                                    "Office of the Governor",
                                                description2:
                                                    "State Ministries",
                                                roomId:
                                                    user.stateOfResidence.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfResidence.name}",
                                                RoomType.HOUSE_OF_ASSEMBLY,
                                                "House of Assem.",
                                                0,
                                                description1:
                                                    "House of Assembly",
                                                description2:
                                                    "State Constituencies",
                                                roomId:
                                                    user.stateOfResidence.id)),
                                        GroupsGridItem(
                                            icon: SvgIconUtils.OTHER_GROUP_ICON,
                                            group: RoomGroupDTO(
                                                "${user.stateOfResidence.name}",
                                                RoomType.LGA,
                                                "${user.localGovtOfResidence.name}",
                                                0,
                                                description1:
                                                    "Resident Local Government",
                                                roomId:
                                                    user.stateOfResidence.id)),
                                      ],
                                    ),
                                  ),
                                  SliverPadding(
                                      padding: EdgeInsets.only(bottom: 32.0))
                                ],
                              );
                            }

                            return LoadingSpinner();
                          }));
                },
                viewModelBuilder: () => HomeViewModel(),
                disposeViewModel: false);
          }

          return LoadingSpinner();
        });
  }

  Widget organizeGrid({List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: children[0]),
              EmptySpace.horizontal(),
              Expanded(child: children[1]),
            ],
          ),
          EmptySpace(),
          Row(
            children: [
              Expanded(child: children[2]),
              EmptySpace.horizontal(),
              Expanded(child: children[3]),
            ],
          )
        ],
      ),
    );
  }
}
//
//Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//  if (message.containsKey('data')) {
//    // Handle data message
//    final dynamic data = message['data'];
//  }
//
//  if (message.containsKey('notification')) {
//    // Handle notification message
//    final dynamic notification = message['notification'];
//  }
//
//  // Or do other work.
//}

class DoNotDisturbSwitch extends StatefulWidget {
  @override
  _DoNotDisturbSwitchState createState() => _DoNotDisturbSwitchState();
}

class _DoNotDisturbSwitchState extends State<DoNotDisturbSwitch> {
  bool _on = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          "Do not disturb",
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        )),
        Switch(
            activeColor: Pallet.primaryColor,
            value: _on,
            onChanged: (selected) {
              _on = selected;
              setState(() {});
            }),
      ],
    );
  }
}
