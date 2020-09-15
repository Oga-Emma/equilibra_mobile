import 'package:cached_network_image/cached_network_image.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:equilibra_mobile/ui/core/widgets/image_preview_screen.dart';
import 'package:equilibra_mobile/ui/core/widgets/profile_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:intl/intl.dart';

class CommentListItems extends StatefulWidget {
  CommentListItems(this.comment, this.user, this.members,
      {this.replyClicked, this.reportClicked, this.like, this.isReply = false});
  List<RoomMember> members;
  CommentDTO comment;
  UserDTO user;
  Function(CommentDTO comment) replyClicked;
  Function(CommentDTO comment) reportClicked;
  Function(CommentDTO comment) like;
  bool isReply;

  @override
  _CommentListItemsState createState() => _CommentListItemsState();
}

class _CommentListItemsState extends State<CommentListItems> {
  bool isExpanded = false;
  bool showReply = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var decoration = BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.6, color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4.0));

    bool liked = widget.comment.liked(widget.user.id);

    return Container(
      margin: EdgeInsets.symmetric(vertical: isExpanded ? 8.0 : 0.0),
      child: Stack(
        children: <Widget>[
          Container(),
          Container(
            padding: EdgeInsets.symmetric(vertical: isExpanded ? 28.0 : 0.0),
            child: InkWell(
              onTap: () {
                if (widget.user.id == widget.comment.author.id ||
                    widget.isReply) {
                  return;
                }
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                color: isExpanded || showReply
                    ? Pallet.selectedCommentBg
                    : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProfileImage(
                        radius: 30,
                        imageUrl: widget.comment.author.avatar ?? "",
                      ),
                      EmptySpace(multiple: 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Text(
                                        StringUtils.isEmpty(
                                                widget.comment.author.username)
                                            ? "${widget.comment.author.fullName}"
                                            : '@${widget.comment.author.username}',
                                        style: textTheme.title.copyWith(
                                            fontSize: 14,
                                            color: widget
                                                    .comment.author.isSuspended
                                                ? Colors.grey[400]
                                                : getColor())),
                                    EmptySpace(),
                                    Visibility(
                                        visible:
                                            widget.comment.author.isSuspended,
                                        child: getNotification(
                                            'suspended', Colors.redAccent)),
                                    EmptySpace(),
                                    Visibility(
                                        visible: widget.comment.reported,
                                        child: getNotification(
                                            'reported', Colors.orangeAccent)),
                                  ],
                                )),
                                EmptySpace(),
                                widget.isReply
                                    ? SizedBox()
                                    : Text("${widget.comment.getDate()}",
                                        style: textTheme.caption
                                            .copyWith(color: Colors.grey)),
                              ],
                            ),
                            EmptySpace(multiple: 0.5),
                            widget.comment.comment == null ||
                                    widget.comment.comment.isEmpty
                                ? SizedBox()
                                : Text(
                                    "${widget.comment.comment}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: widget.comment.author.isSuspended
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                        fontSize: 13),
                                  ),
//                            EmptySpace(multiple: 0.5),
                            widget.comment.likes.isNotEmpty
                                ? Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 24,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: liked
                                            ? Colors.red.withOpacity(0.2)
                                            : Colors.grey[200],
                                        border: Border.all(
                                            width: 0.5,
                                            color: liked
                                                ? Colors.red
                                                : Colors.grey[800]),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Row(
                                      children: <Widget>[
                                        EmptySpace(),
                                        SvgIconUtils.getSvgIcon(
                                            liked
                                                ? SvgIconUtils.LIKED
                                                : SvgIconUtils.LIKE,
                                            width: 16,
                                            height: 16,
                                            color: liked
                                                ? Colors.red
                                                : Colors.grey[800]),
                                        EmptySpace(),
                                        Text(
                                          "${widget.comment.likes.length}",
                                          style: TextStyle(
                                              color: liked
                                                  ? Colors.red
                                                  : Colors.grey[800]),
                                        ),
                                        EmptySpace(),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            widget.comment.replies != null &&
                                    widget.comment.replies.isNotEmpty
                                ? Row(
                                    children: <Widget>[
                                      InkWell(
                                        child: Text(
                                          "Reply",
                                          style: textTheme.headline
                                              .copyWith(fontSize: 12),
                                        ),
                                        onTap: () {
                                          widget.replyClicked(widget.comment);
                                        },
                                      ),
                                      FlatButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              showReply = !showReply;
                                            });
                                          },
                                          icon: Icon(
                                            EvaIcons.messageSquareOutline,
                                            color: Colors.grey,
                                            size: 20,
                                          ),
                                          label: Text(
                                            "${getCommentCount(widget.comment.replies)}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ))
                                    ],
                                  )
                                : SizedBox(),
                            widget.comment.images == null ||
                                    widget.comment.images.isEmpty
                                /*widget.comment.image == null ||
                                    widget.comment.image.isEmpty*/
                                ? SizedBox()
                                : SizedBox(
                                    height: 110,
                                    width: double.maxFinite,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                          widget.comment.images.length,
                                          (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, top: 4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                showImagePreview(context,
                                                    imageUrl: widget
                                                        .comment.images[index]);
//                                                Router.gotoWidget(
//                                                    ImagePreviewScreen(
//                                                        imageUrl: widget.comment
//                                                            .images[index]),
//                                                    context);
                                              },
                                              child: Container(
                                                  height: 100,
                                                  width: 120,
                                                  color: Colors.grey[300],
                                                  child: Image(
                                                      image: CachedNetworkImageProvider(
                                                          widget.comment.images[
                                                                      index] !=
                                                                  null
                                                              ? widget.comment
                                                                  .images[index]
                                                              : ""),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                            repliesContainer(widget.comment.replies),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 16,
              child: !isExpanded
                  ? SizedBox()
                  : Container(
                      decoration: decoration,
                      height: 32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: 52,
                              child: InkWell(
                                  onTap: () {
                                    widget.replyClicked(widget.comment);
                                  },
                                  child: SvgIconUtils.getSvgIcon(
                                      SvgIconUtils.REPLY,
                                      width: 16,
                                      height: 16,
                                      color: Colors.grey[600]))),
                          Container(
                              height: 42,
                              width: 1,
                              color: Colors.grey.withOpacity(0.5)),
                          Container(
                              width: 52,
                              child: InkWell(
                                  onTap: () {
                                    widget.like(widget.comment);
                                    if (widget.comment.liked(widget.user.id)) {
                                      widget.comment.likes
                                          .remove(widget.user.id);
                                    } else {
                                      widget.comment.likes.add(widget.user.id);
                                    }
                                    setState(() {});
                                  },
                                  child: SvgIconUtils.getSvgIcon(
                                      liked
                                          ? SvgIconUtils.LIKED
                                          : SvgIconUtils.LIKE,
                                      width: 16,
                                      height: 16,
                                      color: liked
                                          ? Colors.red
                                          : Colors.grey[800]))),
                          /*Container(
                          height: 42,
                          width: 1,
                          color: Colors.grey.withOpacity(0.5)),
                      Container(
                          width: 52,
                          child: InkWell(
                              onTap: () {},
                              child: SvgIconUtils.getSvgIcon(
                                  SvgIconUtils.LINK,
                                  width: 16,
                                  height: 16,
                                  color: Colors.grey[800]))),*/
                        ],
                      ),
                    )),
          Positioned(
            bottom: 0,
            right: 16,
            child: isExpanded
                ? Container(
                    decoration: decoration,
                    width: 160,
                    height: 32,
                    alignment: Alignment.center,
                    child: FlatButton(
                      child: Text("Report Post",
                          style: TextStyle(color: Colors.grey[600])),
                      onPressed: () {
                        if (widget.reportClicked != null) {
                          widget.reportClicked(widget.comment);
                        }
                      },
                    ),
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }

  repliesContainer(List replies) {
    return !showReply
        ? SizedBox()
        : IgnorePointer(
            ignoring: true,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[]
                    ..addAll(replies.map((reply) => CommentListItems(
                        CommentDTO.fromJson(reply), widget.user, widget.members,
                        isReply: true))),
                )));
  }

  getColor() {
//    var moderator = widget.members.firstWhere(
//        (element) => element.member == widget.comment.author.id,
//        orElse: () => null);

    var moderator = widget.comment.authorType;

    // print(moderator);
    if (moderator == null) {
      return Colors.grey[800];
    }
    //
    // moderator = widget.comment.authorType.toLowerCase();
    //
    moderator = moderator.toLowerCase();

    if (moderator.startsWith('gov')) {
      return Colors.green;
    } else if (moderator.startsWith('pro')) {
      return Colors.blue;
    } else if (moderator.startsWith('pol')) {
      return Colors.red;
    }

    return Colors.grey[800];
  }

  Widget getNotification(String title, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(16.0)),
      child:
          Text(title, style: TextStyle(color: Colors.grey[200], fontSize: 12)),
    );
  }
}

getCommentCount(List replies) {
  return "${replies.length} ${replies.length == 1 ? 'reply' : 'replies'}";
}
