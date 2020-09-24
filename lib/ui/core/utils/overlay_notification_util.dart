import 'dart:convert';

import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

showOverlayMessage(SocketComment comment) {
  showOverlayNotification(
    (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   "${comment.fullComment.comment}",
                  //   style: TextStyle(color: Pallet.primaryColor, fontSize: 14),
                  // ),
                  // Text(
                  //   "${comment.author}",
                  //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  // ),
                  // Divider(),
                  // Text.rich(
                  //   TextSpan(text: "Room: ", children: [
                  //     TextSpan(
                  //         text: '${comment.room}',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 12,
                  //             color: Colors.grey))
                  //   ]),
                  //   style: TextStyle(fontSize: 12, color: Colors.grey),
                  // ),
                  // Text.rich(
                  //   TextSpan(text: "Topic: ", children: [
                  //     TextSpan(
                  //         text: '${comment.topic}',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 12,
                  //             color: Colors.grey))
                  //   ]),
                  //   style: TextStyle(fontSize: 12, color: Colors.grey),
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    },
    duration: Duration(seconds: 4),
  );
}
