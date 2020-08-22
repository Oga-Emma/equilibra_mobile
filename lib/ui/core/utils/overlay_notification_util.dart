import 'dart:convert';

import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showOverlayMessage(data, {Function(bool fetch) fetch}) {
  print("in overlay $data");
  var decode = data; //json.decode(data);
//  var comment = decode['notification']['comment'];
//  print("Room => ${decode['data']['room']}");
  var room = json.decode(data['data']['room']);
//  print("topic => ${decode['data']['comment']}");
  try {
//    var room = RoomDTO.fromNotifMap(decode['room']);
//    var topic = TopicDTO.fromMap(decode['topic']);
//    var notification = NotificationDTO.fromPush(decode);

//    print(decode);
    showOverlayNotification(
      (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () async {
                  fetch(true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${decode['notification']['title']}",
                        style:
                            TextStyle(color: Pallet.primaryColor, fontSize: 14),
                      ),
                      Text(
                        "${decode['notification']['body']}",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Divider(),
                      Text.rich(
                        TextSpan(text: "Room: ", children: [
                          TextSpan(
                              text: '${room['roomName']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey))
                        ]),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      duration: Duration(seconds: 4),
    );
  } catch (e) {
    print("erro => $e}");
  }
}
