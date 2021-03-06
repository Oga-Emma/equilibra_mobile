import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equilibra_mobile/di/controllers/user_controller.dart';
import 'package:equilibra_mobile/model/dto/_voting_dtos.dart';
import 'package:equilibra_mobile/model/dto/admin_notification.dart';
import 'package:equilibra_mobile/model/dto/advert_dto.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/topic_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/model/dto/vote_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/date_utisl.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:equilibra_mobile/ui/core/widgets/image_preview_screen.dart';
import 'package:equilibra_mobile/ui/core/widgets/profile_image.dart';
import 'package:equilibra_mobile/ui/screens/home/room/room_screen/comments/room_comments.dart';
import 'package:equilibra_mobile/ui/screens/home/room/room_screen/topic_title.dart';
import 'package:equilibra_mobile/di/controllers/room_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart' as helper;
import 'package:helper_widgets/loading_spinner.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'room_screen/dialogs_in_room/change_topic_dialog.dart';
import 'room_screen/dialogs_in_room/end_of_topic_voting_dialog.dart';
import 'room_screen/dialogs_in_room/end_of_topic_voting_result_dialog.dart';
import 'room_screen/dialogs_in_room/loading_dialog_helper.dart';
import 'room_screen/dialogs_in_room/report_comment_dialog.dart';
import 'room_screen/dialogs_in_room/suggest_topic_dialog.dart';
import 'room_screen/dialogs_in_room/vote_change_topic_dialog.dart';
import 'room_screen/dialogs_in_room/vote_change_topic_result_dialog.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen(this.roomId, {this.isVentTheSteam = false});
  // RoomScreen(this.group, this.room, {this.isVentTheSteam = false});

  String roomId;
  // RoomGroupDTO group;
  // RoomDTO room;
  bool isVentTheSteam;

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> with helper.ErrorHandler {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var commentController = TextEditingController();
  bool hasTopic = false;

  CommentDTO reply;
  RoomDTO room;

  bool get hasReply => reply != null;
  bool sending = false;

  List dates = [];
  bool isMember = false;

  get loading => room == null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  TextTheme textTheme;
  UserController userController;
  RoomController roomController;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    if (userController == null) {
      userController = Provider.of<UserController>(context, listen: false);
    }

    if (roomController == null) {
      roomController = Provider.of<RoomController>(context, listen: false);
      roomController.reconnect();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: loading
            ? AppBar(
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.white)),
              )
            : null,
        body: room != null
            ? body()
            : FutureBuilder<RoomDTO>(
                future: roomController.fetchRoom(widget.roomId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    room = snapshot.data;
                    Future.delayed(Duration.zero, () {
                      setState(() {});
                    });
                  }
                  return LoadingSpinner();
                }));
  }

  Widget body() {
    widget.isVentTheSteam = room.name.toLowerCase().contains("vent");
    isMember = room.members
        .any((element) => element.member == userController.userProfile.id);

    hasTopic = room.currentTopic != null && room.currentTopic.id != null;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Container(child: _buildCustomScrollView(context, [])),
    );
  }

  List comments;

  bool fetching = false;
  bool error = false;

  Widget _buildCustomScrollView(BuildContext context, List commentList) {
    this.comments = commentList;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      centerTitle: false,
                      leading: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_ios,
                              size: 20, color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0))),
                      pinned: true,
                      title: appBarContent(context),
                      actions: <Widget>[
                        widget.isVentTheSteam
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/img/room_topic_side_image.png")),
                                  ),
                                ),
                              )
                            : _selectPopup()
                      ],
                      expandedHeight: widget.isVentTheSteam
                          ? 56
                          : !hasTopic
                              ? 190
                              : 230,
                      flexibleSpace: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24.0),
                            bottomRight: Radius.circular(24.0)),
                        child: Container(
                          child: SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 56),
                                  Visibility(
                                    visible: hasTopic && !widget.isVentTheSteam,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SvgIconUtils.getSvgIcon(
                                                  SvgIconUtils.CLOCK,
                                                  color: Colors.white,
                                                  height: 18,
                                                  width: 18),
                                              EmptySpace(),
                                              CountDownToTopicEnd(room)
//                                            CountDownToTopicEnd(widget
//                                                .room.currentTopic.startDate)
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TopicTitle(
                                      room: room,
                                      isVentTheSteam: widget.isVentTheSteam)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                        child: Column(
                      children: [
                        Visibility(
                            visible: !widget.isVentTheSteam,
                            child: AdminNotification(
                                userController: userController,
                                roomController: roomController,
                                room: room)),
                        Expanded(
                          child: RoomComments(
                              room: room,
                              handleEvent: handleEvent,
                              replyClicked: (CommentDTO comment) {
                                setState(() {
                                  reply = comment;
                                });
                              },
                              reportClicked: (CommentDTO comment) {
                                showDialog(
                                    context: context,
                                    builder: (context) => ReportCommentDialog(
                                            onSubmit: (String message) {
                                          Navigator.pop(context);
                                          reportComment(comment.id, message);
                                        }));
                              },
                              deleteClicked: (CommentDTO comment) {
                                deleteComment(comment.id);
                              },
                              like: (comment) {
                                if (comment
                                    .liked(userController.userProfile.id)) {
                                  unlikeComment(comment.id);
                                } else {
                                  likeComment(comment.id);
                                }
                              }),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.white,
              elevation: 0.0,
              child: Container(
                width: double.maxFinite,
                child: SafeArea(
                    top: false,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: widget.isVentTheSteam || isMember
                            ? commentLayout()
                            : JoinRoom(room.id))),
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 100,
            right: 8,
            child: widget.isVentTheSteam || !isMember || hasReply
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () {
                      _fabClicked(context);
                    },
                    child: Icon(Icons.add),
                    mini: true)),
      ],
    );
  }

  Widget appBarContent(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: widget.isVentTheSteam
          ? Text("Vent the Steam")
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //   Text("${widget.group.groupName}",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w300,
                //           fontSize: 16.0,
                //           color: Colors.white.withOpacity(0.7))),
                //   Icon(Icons.arrow_forward_ios, size: 14.0, color: Colors.white),
                //   EmptySpace(multiple: 0.5),
                Text(
                    toTitleCase(
                        "${room.name} - ${room.government != null ? room.government['name'] : ''}"),
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ],
            ),
    );
  }

  String toTitleCase(String sentence) {
    if (StringUtils.isEmpty(sentence)) return "";

    var split = sentence.trim().split(' ');

    //print(split);
    return split
        .map((word) {
          if (word == null || word.length < 2) {
            return word;
          }

          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .toList()
        .join(" ");
  }

  Widget commentLayout() {
    fetchAdvert();
    return Column(
      children: <Widget>[
        commentImage != null && commentImage.isNotEmpty
            ? SizedBox(
                height: 110,
                width: double.maxFinite,
                child: ListView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(commentImage.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
//                          Router.gotoWidget(ImagePreviewScreen(file: ), context);
                                    showImagePreview(context,
                                        file: commentImage[index]);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 130,
                                    color: Colors.grey,
                                    child: Hero(
                                      tag: 'image',
                                      child: Image(
                                          image: FileImage(
                                              commentImage[index] != null
                                                  ? commentImage[index]
                                                  : ""),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                        child: Container(
                                            color: Colors.black12,
                                            child: Icon(Icons.cancel,
                                                color: Colors.white)),
                                        onTap: () {
                                          setState(() {
                                            commentImage.removeAt(index);
                                          });
                                        }))
                              ],
                            )),
                      );
                    })),
              )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: pickImage,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgIconUtils.getSvgIcon(
                      SvgIconUtils.COMMENT_ADD_IMAGE_SEND,
                      color: Colors.grey,
                      height: 20,
                      width: 20),
                ),
              ),
              EmptySpace(multiple: 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    hasReply ? replyContainer() : SizedBox(),
                    TextField(
                      controller: commentController,
                      maxLines: 10,
                      minLines: 1,
                      decoration: hasReply ||
                              (commentImage != null && commentImage.isNotEmpty)
                          ? InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                gapPadding: 4.0,
                              ),
                              hintText: "Type a message...",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14))
                          : InputDecoration.collapsed(
                              hintText: "Type a message...",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                    ),
                  ],
                ),
              ),
              EmptySpace(),
              InkWell(
                  onTap: () async {
                    if (room.currentTopic == null) {
                      showErrorToast(
                          "This room has no topic, please set a topic to start a discussion");
                      return;
                    }
//                    FocusScope.of(context).requestFocus(new FocusNode());
                    //send comment then refetch
                    String message = commentController.text;
                    if ((commentImage == null || commentImage.isEmpty) &&
                        StringUtils.isEmpty(message)) {
                      return;
                    }
                    //////print(message);

//            var topicId = room.currentTopic.id;

                    setState(() {
                      sending = true;
                    });

                    try {
                      if (hasReply) {
                        await replyComment(reply, message, commentImage);
                      } else {
                        await makeComment(message, commentImage);
                      }

                      setState(() {
                        sending = false;
                      });

//              if (refetch != null) {
//                refetch();
//              }
                    } catch (e) {
                      //////print("Error => $e");
                      showErrorToast(getErrorMessage(e));
                      setState(() {
                        sending = false;
                      });
                    }
                  },
                  child: sending
                      ? Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()))
                      : Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SvgIconUtils.getSvgIcon(
                              SvgIconUtils.COMMENT_SEND,
                              color: Colors.grey,
                              height: 20,
                              width: 20),
                        ))
            ],
          ),
        ),
      ],
    );
  }

  Widget replyContainer() {
    return Container(
      width: double.maxFinite,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 24.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "@${StringUtils.toTitleCase(reply.author.fullName)}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${reply.comment}"),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: () {
                setState(() {
                  reply = null;
                });
              },
              child: Icon(Icons.cancel, size: 20, color: Colors.grey[700]),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
    );
  }

  joinRoom() async {
//    showLoadingDialog(context);
  }

  List<File> commentImage = [];

  Future pickImage() async {
    if (commentImage == null) {
      commentImage = [];
    }
    try {
//      checkPermission();

      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//      var image = await FilePicker.getFile(type: FileType.IMAGE);
//      var images = await MultiImagePicker.pickImages(
//        maxImages: 4,
//      );

      if (image != null) {
        commentImage.add(image);
//        commentImage.addAll(images);
//        commentImage.add(File(await images[0].filePath));
        setState(() {});
      }
    } on PlatformException catch (e) {
      ////print("Error => $e");
    } catch (e) {
      ////print("Error => $e");
    }
  }

  Future makeComment(String comment, List<File> file) async {
    try {
      if (room.currentTopic == null || room.currentTopic.id == null) {
        showNoTopicMessage();
        return;
      }

      await roomController.createComments(
          images: file,
          comment: comment,
          topicId: room.currentTopic.id,
          roomId: room.id);

      clearComment();
    } catch (err) {
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  clearComment() {
    setState(() {
      reply = null;
      commentImage = null;
      commentController.clear();
    });
  }

  Future replyComment(CommentDTO reply, String comment, List<File> file) async {
    // //print("replying...");
    try {
      await roomController.replyComment(
          images: file, comment: comment, commentId: reply.id);

      clearComment();
    } catch (err) {
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  Future reportComment(String commentId, String reportType) async {
    try {
      await roomController.reportComment(
          report: reportType, commentId: commentId);
      showSuccessToast("Comment reported");
    } catch (err) {
      //print(err);
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  Future deleteComment(id) async {
    try {
      await roomController.deleteComment(id);
      // showSuccessToast("Comment reported");
    } catch (err) {
      //print(err);
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  Future likeComment(String commentId) async {
    try {
      await roomController.likeComment(commentId);
      clearComment();
    } catch (err) {
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  Future unlikeComment(String commentId) async {
    try {
      await roomController.unlikeComment(commentId);
      clearComment();
    } catch (err) {
      showErrorToast(getErrorMessage(err, "Error sending comment"));
    }
  }

  static const int SUGGEST_TOPIC = 1;
  static const int CHANGE_TOPIC = 2;

  Future _fabClicked(context) async {
//    _voteChangeTopicDialog('123', 'Hello world', 'Some random description');
//    return;
    int choice = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => BottomSheet(
              onClosing: () {},
              backgroundColor: Colors.transparent,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                        height: 42,
                        width: double.maxFinite,
                        child: RaisedButton(
                            shape: StadiumBorder(),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context, SUGGEST_TOPIC);
                            },
                            child: Text(
                              "Suggest Topic",
                              style: TextStyle(color: Pallet.primaryColor),
                            ))),
                    EmptySpace(multiple: 2),
                    SizedBox(
                        height: 42,
                        width: double.maxFinite,
                        child: RaisedButton(
                            shape: StadiumBorder(),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context, CHANGE_TOPIC);
                            },
                            child: Text(
                              "Change Topic",
                              style: TextStyle(color: Pallet.primaryColor),
                            ))),
                  ],
                ),
              ),
            ));

    if (choice == CHANGE_TOPIC) {
      _changeTopicDialog();
    } else if (choice == SUGGEST_TOPIC) {
      _suggestTopicDialog();
    }
  }

  TextStyle get popStyle => TextStyle(fontSize: 14);

  Widget _selectPopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[
                  ProfileImage(
                      imageUrl: userController.userProfile.avatar, radius: 30),
                  EmptySpace(),
                  Text(
                      "${userController.userProfile.username ?? userController.userProfile.fullName}")
                ],
              )),
          PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.exit_to_app, color: Pallet.primaryColor, size: 20),
                  EmptySpace(),
                  Text("Leave Room"),
                ],
              )),
//          PopupMenuItem(
//            value: 3,
//            child: Text("Mute Notifications", style: popStyle),
//          ),
//          PopupMenuItem(
//            value: 7,
//            child: Text("Settings", style: popStyle),
//          ),
        ],
        initialValue: 1,
        onCanceled: () {
//      //////print("You have canceled the menu.");
        },
        onSelected: (value) async {
//      //////print("value:$value");
          switch (value) {
            case 1:
              {
                try {
                  showLoadingDialog(context);
                  await roomController.leaveRoom(room.id);
                  isMember = false;
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (err) {
                  showErrorToast(
                      "Error leaving room, please check your internet and try again");
                  Navigator.pop(context);
                }
                break;
              }
            default:
              {
                break;
              }
          }
        },
        icon: Icon(Icons.more_vert),
        offset: Offset(0, 180),
      );

  var _suggestTopicIsShown = false;

  _suggestTopicDialog() async {
    try {
      _suggestTopicIsShown = true;
      await showDialog(
          context: context, builder: (context) => SuggestTopicDialog(room));
    } catch (err) {
      if (_suggestTopicIsShown) {
        _suggestTopicIsShown = false;
      }
    }
  }

  var _voteTopicIsShown = false;

  _voteTopicResultDialog(String title, String description, bool change) async {
    try {
      if (_voteTopicIsShown) return;
      if (room.members != null && room.members.length > 1) {
        _voteTopicIsShown = true;
        await showDialog(
            context: context,
            builder: (context) =>
                VoteChangeTopicResultDialog(title, description, change));
        _voteTopicIsShown = false;
      }
      setState(() {
        room = null;
      });
    } catch (err) {
      if (_voteTopicIsShown) {
        _voteTopicIsShown = false;
      }
    }
  }

  bool changeFromMe = false;

  _changeTopicDialog() async {
    bool change = await showDialog(
        context: context, builder: (context) => ChangeTopicDialog(room));

    if (change != null && change) {
      changeFromMe = true;
      if (room.currentTopic == null) {
        showSuccessToast("Request sent");
      } else {
        showSuccessToast("Request sent, voting will commence shortly");
      }
    }
  }

  showNoTopicMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("You can't comment here, room currently has no topic."),
      action: SnackBarAction(
        label: "SET TOPIC",
        onPressed: () {
          _changeTopicDialog();
        },
      ),
    ));
  }

  bool fetched = false;

  Future fetchAdvert() async {}

  handleEvent(EventHandler event) {
    try {
      switch (event.type) {
        case EventTypes.COMMENT:
          // TODO: Handle this case.
          break;

        case EventTypes.JOIN_ROOM:
          if (userController.userProfile.id == event.data["user"]) {
            if (votingTopicChange) {
              Navigator.pop(context);
            }
            refreshPage();
          }
          //print("join event => ${event.data}");
          break;

        case EventTypes.LEAVE_ROOM:
          refreshPage();
          break;

        case EventTypes.TOPIC_CHANGED:
          if (!isMember) return;
          refreshPage();
          break;

        case EventTypes.VOTE_TOPIC_CHANGE:
          if (!isMember) return;
          var vote = VoteDTO.fromMap(event.data['vote']);

          // print((vote.voters ?? []).contains(userController.userProfile.id));
          // print(userController.userProfile.id);
          // print(vote.voters);
          // print(vote.stopAt);
          // print(vote.isClosed);
          // print(vote.id);

          if (roomController.voted.contains(vote.id)) return;

          if ((vote.voters ?? []).contains(userController.userProfile.id))
            return;
          voteChangeTopic(vote);
          break;

        case EventTypes.VOTE_TOPIC_CLOSED:
          if (!isMember) return;
          if (votingTopicChange) {
            Navigator.pop(context);
          }

          var vote = VoteDTO.fromMap(event.data['vote']);
          showChangeTopicVotingResult(vote);
          break;

        case EventTypes.VOTE_DISCUSSION:
          if (!isMember) return;
//        //print(event.data['vote']);
          var vote = VoteDTO.fromMap(event.data['vote']);

          if (!vote.voters.contains(userController.userProfile.id)) {
            showDiscussionVote(vote);
          }
          break;

        case EventTypes.VOTE_DISCUSSION_CLOSED:
          if (!isMember) return;
          var vote = VoteDTO.fromMap(event.data['vote']);
          endOfTopicVotingResultDialog(vote);
          break;
      }
    } catch (err) {
      //print(err);
    }
  }

  void refreshPage() {
    if (votingTopicChange) return;
    setState(() {
      room = null;
    });
  }

  bool votingTopicChange = false;
  void voteChangeTopic(VoteDTO vote) async {
    if (votingTopicChange) return;
    DateTime stopAt = DateTime.now()..add(Duration(minutes: 2));
    if (vote.stopAt != null) {
      stopAt = DateTime.tryParse(vote.stopAt);
    }

    var difference = DateTime.now().difference(stopAt);
//
//    if(changeFromMe){
//
//    }

    votingTopicChange = true;
    await showDialog(
        context: context,
        builder: (context) => VoteChangeTopicDialog(
            vote.id, vote.topicId.title, vote.topicId.description,
            autoVote: room.members.length != null && room.members.length == 1,
            stopAt: stopAt));

    votingTopicChange = false;

    try {
      if (room.currentTopic == null) {
        if (changeFromMe) {
          Future.delayed(difference.inSeconds < 1 ? Duration.zero : difference,
              () => closeVotingSession(vote.id));
        }
      } else {
        if (changeFromMe) {
          changeFromMe = false;
          if (room.members != null && room.members.length == 1) {
            refreshPage();
            return;
          }

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Voting in progress".toUpperCase(),
                      style: TextStyle(color: Pallet.primaryColor),
                    ),
                    EmptySpace(multiple: 2),
                    Text(
                      "Voting for the topic you suggested has commenced. \n\nPlease note: A voting session takes 2 - 5 minutes. \n\nYou have to remain in the room while voting is in progress to successfully change the topic",
                      textAlign: TextAlign.center,
                    )
                  ],
                ));
              });
          ////print("Please wait, closing soon");

        }
//        ////print("Voting failed");
      }
    } catch (e) {
      ////print(e);
    }
  }

  Future<void> showChangeTopicVotingResult(VoteDTO vote) async {
    bool changed = vote.status != "un-changed";
    if (vote.roomId.members != null && vote.roomId.members.length > 1) {
      _voteTopicIsShown = true;
      await showDialog(
          context: context,
          builder: (context) => VoteChangeTopicResultDialog(
              vote.topicId.title, vote.topicId.description, changed));
      _voteTopicIsShown = false;
    }
    if (changed) {
      refreshPage();
    }
  }

  Future<void> showDiscussionVote(VoteDTO vote) async {
    if (vote.topicId == null || vote.roomId == null) return;
    VotingResult result = await showDialog(
        context: context,
        builder: (context) => EndOfTopicVotingDialog(vote.topicId, vote.id));
  }

  endOfTopicVotingResultDialog(VoteDTO vote) async {
    await showDialog(
        context: context,
        builder: (context) => EndOfTopicVotingResultDialog(vote));
  }

  closeVotingSession(id) {}
}

class AdminNotification extends StatefulWidget {
  AdminNotification({this.roomController, this.userController, this.room});
  RoomDTO room;
  RoomController roomController;
  UserController userController;

  @override
  _AdminNotificationState createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  AdminNotificationDTO _adminNotification;
  RoomController roomController;

  var textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    if (widget.userController == null) {
      widget.userController =
          Provider.of<UserController>(context, listen: false);
    }

    if (roomController == null) {
      roomController = widget.roomController;
      roomController.reconnect();
      fetchNotificationAndAdverts();
    }

    return _adminNotification != null ? _buildAdminNotification() : SizedBox();
  }

  Future<void> fetchNotificationAndAdverts() async {
    // print(
    //     "fetching notification => ${roomController.fetchRoomAdvert(roomId: widget.room.id)}");
    try {
      roomController
          .fetchRoomAdvert(roomId: widget.room.id)
          .then((List<AdvertDTO> value) {
        if (value.isEmpty) return;
        value..shuffle();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.all(0),
            insetPadding: EdgeInsets.all(8),
            content: CachedNetworkImage(
              placeholder: (context, text) => SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: LoadingSpinner()),
              errorWidget: (context, _, __) {
                return Container(
                  height: 200,
                  width: double.maxFinite,
                  color: Colors.grey,
                );
              },
              imageUrl: value.last.image,
              fit: BoxFit.contain,
            ),
          ),
        );
      }).catchError((err) {
        print(err);
      });

      roomController
          .fetchAdminNotification(
              roomId: widget.room.id,
              userId: widget.userController.userProfile.id)
          .then((AdminNotificationDTO value) {
        if (value.rooms.contains(widget.room.id)) {
          setState(() {
            _adminNotification = value;
          });
        }
      }).catchError((err) {
        print(err);
      });
    } catch (err) {}
  }

  Widget _buildAdminNotification() {
    return Visibility(
      visible: !_adminNotification.mutedUsers
          .contains(widget.userController.userProfile.id),
      child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Pallet.primaryColor,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${_adminNotification.message}".trim(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                  onTap: () {
                    setState(() {
                      _adminNotification.mutedUsers
                          .add(widget.userController.userProfile.id);
                    });
                    roomController.muteAdminNotification(
                        notificationId: _adminNotification.id,
                        userId: widget.userController.userProfile.id);
                  })
            ],
          )),
    );
  }
}

class CountDownToTopicEnd extends StatefulWidget {
  CountDownToTopicEnd(this.room);

  RoomDTO room;

  @override
  _CountDownToTopicEndState createState() => _CountDownToTopicEndState();
}

class _CountDownToTopicEndState extends State<CountDownToTopicEnd> {
  Duration duration;
  var format = DateFormat("H:m");

  Timer _timer;
  int _start = 10;

  DateTime startDate;

  @override
  void initState() {
//    //print("${room}");
//    //print("${room.updatedAt}");
//    //print("${room.topicStartDate}");
//    //print("${room.createdAt}");

    if (widget.room.topicStartDate != null) {
      try {
        startDate = DateTime.tryParse(widget.room.topicStartDate);
      } catch (err) {
        //print(err);
      }
    }
    updateView();

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          updateView();
        },
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (startDate == null) {
      return Text('');
    }
    return Text(
      "${DateUtils.getTimeToTopicChange(duration)}",
//                                              "5 Day(s) 15 Hours 56 Minutes",
      style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
    );
  }

  void updateView() {
    if (startDate == null) return;

//    //print('updating...');

    DateTime now = DateTime.now();
    var hourMins = format.format(now);
    var minute = 0;
    var hour = 0;

    try {
      var split = hourMins.split(':');
      hour = int.parse(split[0]);
      minute = int.parse(split[1]);
    } catch (e) {
      ////print(e);
    }

    var next7Days = startDate.add(Duration(days: 7));

    /*var sunday = now.add(Duration(
        days: DateTime.sunday - now.weekday,
        hours: 23 - hour,
        minutes: 59 - minute));*/

    duration = next7Days.difference(now);
  }
}

class JoinRoom extends StatelessWidget {
  JoinRoom(this.roomId);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RoomController>(context);
    return EButton(
        label: "Join Room",
        onTap: () {
//          //print(roomId);
          controller.joinRoom(roomId);
        },
        loading: controller.isBusy);
  }
}
