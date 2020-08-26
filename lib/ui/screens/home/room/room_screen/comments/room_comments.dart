import 'package:equilibra_mobile/di/controllers/room_controller.dart';
import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/utils/date_utisl.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/screens/home/room/room_screen/dialogs_in_room/report_comment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/loading_spinner.dart';

import 'comment_list_items.dart';

class RoomComments extends StatefulWidget {
  RoomComments({this.room, this.replyClicked, this.reportClicked, this.like});
  RoomDTO room;
  Function(CommentDTO comment) replyClicked;
  Function(CommentDTO comment) reportClicked;
  Function(CommentDTO comment) like;
  @override
  _RoomCommentsState createState() => _RoomCommentsState();
}

class _RoomCommentsState extends State<RoomComments> {
  final animatedListKey = GlobalKey<AnimatedListState>();
  List<CommentDTO> comments = [];

  UserController userController;
  RoomController roomController;

  @override
  void dispose() {
    if (roomController != null) {
      roomController.connectHomeEvent();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userController = Provider.of<UserController>(context);

    if (roomController == null) {
      roomController = Provider.of<RoomController>(context);
      roomController.connectRoomEvent().listen(handleEvents);
    }

//    print(widget.room);
//    print(widget.room.id);
//    print(widget.room.currentTopic);
//    print(widget.room.currentTopic.id);

    if (comments.isNotEmpty) {
      return _buildList();
    }
    if (widget.room == null || widget.room.currentTopic == null) {
      return _buildList();
    }
    return FutureBuilder<List<CommentDTO>>(
        future: roomController.fetchComments(
            roomId: widget.room.id, topicId: widget.room.currentTopic.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            comments = snapshot.data;

            return _buildList();
          }

          return LoadingSpinner();
        });
  }

  Widget _buildList() {
    if (comments.isEmpty) {
      return noComment;
    }

    return Container(
      child: AnimatedList(
          reverse: true,
          key: animatedListKey,
          initialItemCount: comments.length,
          itemBuilder: (context, index, animation) {
            var commentDTO =
                comments[index]; //CommentDTO.fromJson(comments[index]);

            var prevComment = commentDTO;

            bool showDate = false;
            if (index != 0) {
              prevComment =
                  comments[index]; //CommentDTO.fromJson(comments[index - 1]);
              var day = DateUtils.getTimeStamp(commentDTO.createdAt);

              if (day != DateUtils.getTimeStamp(prevComment.createdAt)) {
                showDate = true;
              }
            }

            return SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CommentListItems(
                        commentDTO, userController.user, widget.room.members,
                        replyClicked: widget.replyClicked,
                        like: widget.like,
                        reportClicked: widget.reportClicked),
                    showDate
                        ? Row(
                            children: <Widget>[
                              Expanded(child: _line),
                              Text(
                                  "${DateUtils.getDate(prevComment.createdAt)}"),
                              Expanded(child: _line),
                            ],
                          )
                        : SizedBox(),
                  ],
                ));
          }),
    );
  }

  Widget get error => Center(
      child: Text("Error fetching data\nPlease check your internet",
          textAlign: TextAlign.center));

  Widget get noComment => Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgIconUtils.getSvgNoColor(SvgIconUtils.NO_COMMENT,
                width: 50, height: 50),
            EmptySpace(multiple: 2),
            Text("No ongoing chat",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center),
            EmptySpace(multiple: 0.5),
            Text("Be the first to leave a comment",
                textAlign: TextAlign.center),
          ],
        ),
      ));

  final _line = Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    height: 1,
    width: double.maxFinite,
    color: Colors.grey[300],
  );

  void handleEvents(EventHandler event) {
    if (event.type == EventTypes.COMMENT) {
      var socketComment = event.data as SocketComment;

      if (socketComment.room == widget.room.id &&
          widget.room.currentTopic != null &&
          socketComment.topic == widget.room.currentTopic.id) {
        var comment = socketComment.fullComment;
        switch (socketComment.type) {
          case SocketCommentTypes.NEW_COMMENT:
            {
              comments.insert(0, comment);
              animatedListKey.currentState.insertItem(0);
              break;
            }
          case SocketCommentTypes.DELETE:
            {
              var index =
                  comments.indexWhere((element) => element.id == comment.id);
              if (index != -1) {
                setState(() {
                  comments.removeAt(index);
                });
//                animatedListKey.currentState.removeItem(index);
              }
              break;
            }
          default:
            {
              var index =
                  comments.indexWhere((element) => element.id == comment.id);
              if (index != -1) {
                setState(() {
                  comments[index] = comment;
                });
              }
            }
        }
      }
    }
  }
}
