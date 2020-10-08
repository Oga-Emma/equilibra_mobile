import 'package:equilibra_mobile/di/controllers/data_controller.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/di/controllers/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:stacked/stacked.dart';

class RoomGroupsListScreen extends StatelessWidget {
  RoomGroupsListScreen(this.group, {this.getVentTheSteam = false});

  RoomGroupDTO group;
  bool getVentTheSteam;

  TextTheme textTheme;
  DataController controller;
  RoomController roomController;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    controller = Provider.of<DataController>(context);
    roomController = Provider.of<RoomController>(context);

    return ViewModelBuilder<RoomController>.nonReactive(
        builder: (context, model, child) {
          return Scaffold(
              appBar: RoomListAppBar(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios,
                            size: 20, color: Colors.white)),
                    EmptySpace(),
                    Text(StringUtils.toTitleCase("${group.groupName}"),
                        style: TextStyle(fontSize: 16.0, color: Colors.white)),
                    EmptySpace(multiple: 0.5),
                    group.ventTheSteam
                        ? SizedBox()
                        : Icon(Icons.arrow_forward_ios,
                            size: 14.0, color: Colors.white.withOpacity(0.7)),
                    EmptySpace(multiple: 0.5),
                    group.ventTheSteam
                        ? SizedBox()
                        : Text("${group.title}",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0,
                                color: Colors.white)),
                  ],
                ),
              ),
              body: Container(
                  child: StreamBuilder<Map<String, List<RoomDTO>>>(
                      stream: group.isFederal
                          ? controller.fetchFederalRooms(group.roomType)
                          : group.isOrigin
                              ? controller.fetchStateOfOriginRooms(
                                  group.roomId, group.roomType)
                              : controller.fetchStateOfResidenceRooms(
                                  group.roomId, group.roomType),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data.containsKey(group.roomType)) {
                          return _buildRooms(
                              snapshot.data[group.roomType], model);
                        }

                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return LoadingSpinner();
                      })));
        },
        viewModelBuilder: () => roomController,
        disposeViewModel: false);
  }

  String getInitials(String name) {
    var split = name.trim().split(" ");
    if ((name.toLowerCase().contains('fed min of') ||
            name.toLowerCase().contains('fed min for')) &&
        split.length > 3) {
      if (name.contains('&') || name.toLowerCase().contains('and')) {
        return "${split[3][0]}${split[5][0]}".toUpperCase();
      } else if (split.length > 4) {
        return "${split[3][0]}${split[4][0]}".toUpperCase();
      }

      return "${split[3][0]}${split[3][1]}".toUpperCase();
    } else if (name.toLowerCase().contains('min of') && split.length > 2) {
      if (name.contains('&') || name.toLowerCase().contains('and')) {
        return "${split[3][0]}${split[5][0]}".toUpperCase();
      } else if (split.length > 4) {
        return "${split[3][0]}${split[4][0]}".toUpperCase();
      }

      return "${split[3][0]}${split[3][1]}".toUpperCase();
    } else if (name.toLowerCase().contains('federal high court') &&
        split.length > 3) {
      return "${split[3][0]}${split[3][1]}".toUpperCase();
    } else if (split.length < 2) {
      return name.substring(0, 2).toUpperCase();
    } else {
      if (split[0].isEmpty) {
        return split[1][0];
      }
      if (split[1].isEmpty) {
        return split[1][0];
      }
      return "${split[0][0]}${split[1][0]}".toUpperCase();
//      return "${split[0][0]}${split[1][0]}".toUpperCase();
    }
  }

  Widget _buildRooms(List<RoomDTO> rooms, RoomController model) {
    if (getVentTheSteam) {
      Future.delayed(Duration.zero, () {
        var room = rooms.firstWhere(
            (room) => room.name.toLowerCase().contains("vent"),
            orElse: () => null);
        if (room != null) {
          model.showVentTheSteam(room);
        }
      });
    }
    return ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          var room = rooms[index];
          return ListTile(
            onTap: () {
//              print(room.id);
              model.gotoRoomScreen(
                room.id,
                isVentTheSteam: room.name.toLowerCase().contains("vent"),
              );

//                Router.gotoWidget(
//                    RoomScreen(
//                      group,
//                      room,
//                      isVentTheSteam: room.name
//                          .toLowerCase()
//                          .contains("vent the steam"),
//                    ),
//                    context);
            },
            title: Text(
              room.name,
              style: textTheme.title.copyWith(fontSize: 14),
            ),
            subtitle: Text(StringUtils.toTitleCase(room.slug),
                style: textTheme.caption.copyWith(color: Colors.grey)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            leading: Container(
              height: 46,
              width: 46,
              child: Stack(
                children: <Widget>[
                  SvgIconUtils.getSvgIcon(SvgIconUtils.GROUP_INITIAL_BG,
                      height: 46, width: 46),
                  Center(
                      child: Text(
                    "${getInitials(room.name)}",
                    style: textTheme.title
                        .copyWith(fontSize: 14, color: Pallet.primaryColor),
                  )),
                ],
              ),
            ),
          );
        });
  }
}

class RoomListAppBar extends StatelessWidget with PreferredSizeWidget {
  RoomListAppBar({@required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Pallet.primaryColor,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: child,
      )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class JoinRoomDialog extends StatefulWidget {
  JoinRoomDialog(this.roomId);
  String roomId;

  @override
  _JoinRoomDialogState createState() => _JoinRoomDialogState();
}

class _JoinRoomDialogState extends State<JoinRoomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("You are not a member of this room"),
            Text("Click below to join"),
            EmptySpace(),
            RaisedButton(
                onPressed: () {},
                color: Pallet.primaryColor,
                child: Text("Join Room", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
