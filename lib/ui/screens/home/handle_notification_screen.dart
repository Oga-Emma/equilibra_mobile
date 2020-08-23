//import 'package:equilibra/app_state_provider.dart';
//import 'package:equilibra/graphql/room_query_mutation.dart';
//import 'package:equilibra/model/room_dto.dart';
//import 'package:equilibra/ui/home/group/room_screen.dart';
//import 'package:equilibra/ui/router/router.dart';
//import 'package:equilibra/ui/widgets/ui_loading_spinner.dart';
//import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//import 'package:flutter/material.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'package:provider/provider.dart';
//
//class HandleNotificationScreen extends StatefulWidget {
//  HandleNotificationScreen(this.roomId);
//  var roomId;
//  @override
//  _HandleNotificationScreenState createState() =>
//      _HandleNotificationScreenState();
//}
//
//class _HandleNotificationScreenState extends State<HandleNotificationScreen> {
//  @override
//  Widget build(BuildContext context) {
//    var appState = Provider.of<AppStateProvider>(context);
//
//    return Scaffold(
//        body: Query(
//      options: QueryOptions(
//        context: <String, dynamic>{
//          'headers': <String, String>{
//            'Authorization': 'Bearer ${appState.token}',
//          },
//        },
//        document: RoomQueryMutation.getRoom(), //
//        variables: {
//          'roomId': widget.roomId
//        }, // this is the query string you just created
//      ),
//      builder: (QueryResult result,
//          {VoidCallback refetch, FetchMore fetchMore}) {
//        if (result.loading) {
//          return Center(child: CircularProgressIndicator());
//        }
//
//        if (result.hasException) {
////          print("Errors => ${result.exception.toString()}");
//          return Center(
//              child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text("Error fetching data"),
//              Text("Please check your network"),
//              OutlineButton.icon(
//                  shape: StadiumBorder(),
//                  onPressed: () {
//                    setState(() {});
//                  },
//                  icon: Icon(EvaIcons.refreshOutline),
//                  label: Text("Retry"))
//            ],
//          ));
//        }
//
//        if (result.data != null) {
//          var room = RoomDTO.fromMap(
//              (result.data as LazyCacheMap).data['getRoomById']);
//
//          print(
//              "result => ${(result.data as LazyCacheMap).data['getRoomById']}");
//
//          Future.delayed(Duration.zero, () {
//            Navigator.pop(context, room);
//          });
//        } else {
////              print("rooms => $rooms");
//        }
//        return LoadingSpinner();
//      },
//    ));
//  }
//}
