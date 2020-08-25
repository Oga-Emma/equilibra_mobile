//import 'package:flutter/material.dart';
//
//class RoomComments extends StatelessWidget {
//  List comments;
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Column(
//          children: <Widget>[
//            Expanded(
//              child: CustomScrollView(
//                slivers: <Widget>[
//                  SliverAppBar(
//                    centerTitle: false,
//                    leading: InkWell(
//                        onTap: () => Navigator.pop(context),
//                        child: Icon(Icons.arrow_back_ios,
//                            size: 20, color: Colors.white)),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.only(
//                            bottomLeft: Radius.circular(16.0),
//                            bottomRight: Radius.circular(16.0))),
//                    pinned: true,
//                    title: appBarContent(context),
//                    actions:
//                    isVentTheSteam ? <Widget>[_selectPopup()] : null,
//                    expandedHeight:
//                    isVentTheSteam || !hasTopic ? 190 : 260,
//                    flexibleSpace: ClipRRect(
//                      borderRadius: BorderRadius.only(
//                          bottomLeft: Radius.circular(24.0),
//                          bottomRight: Radius.circular(24.0)),
//                      child: Container(
//                        child: SafeArea(
//                          child: SingleChildScrollView(
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                SizedBox(height: 56),
//                                hasTopic && !isVentTheSteam
//                                    ? Container(
//                                  padding: EdgeInsets.all(8.0),
//                                  child: Row(
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      SvgIconUtils.getSvgIcon(
//                                          SvgIconUtils.CLOCK,
//                                          color: Colors.white,
//                                          height: 18,
//                                          width: 18),
//                                      emptySpace(),
//                                      Text(
//                                        "${room.currentTopic.startDate}",
////                                              "5 Day(s) 15 Hours 56 Minutes",
//                                        style: Theme.of(context)
//                                            .textTheme
//                                            .caption
//                                            .copyWith(
//                                            color: Colors.white),
//                                      )
//                                    ],
//                                  ),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          color: Colors.white)),
//                                )
//                                    : SizedBox(),
//                                emptySpace(),
//                                TopicTitle(
//                                    room: room,
//                                    isVentTheSteam: isVentTheSteam)
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                  loading
//                      ? SliverFillRemaining(
//                    child: Center(child: CircularProgressIndicator()),
//                  )
//                      : error
//                      ? SliverFillRemaining(
//                    child: Center(
//                        child: Text(
//                            "Error fetching data\nPlease check your internet",
//                            textAlign: TextAlign.center)),
//                  )
//                      : comments.isEmpty
//                      ? SliverFillRemaining(
//                    child: Center(
//                        child: SingleChildScrollView(
//                          child: Column(
//                            mainAxisAlignment:
//                            MainAxisAlignment.center,
//                            children: <Widget>[
//                              SvgIconUtils.getSvgNoColor(
//                                  SvgIconUtils.NO_COMMENT,
//                                  width: 50,
//                                  height: 50),
//                              emptySpace(multiple: 2),
//                              Text("No ongoing chat",
//                                  style: Theme.of(context)
//                                      .textTheme
//                                      .title
//                                      .copyWith(fontSize: 18),
//                                  textAlign: TextAlign.center),
//                              emptySpace(multiple: 0.5),
//                              Text("Be the first to leave a comment",
//                                  textAlign: TextAlign.center),
//                            ],
//                          ),
//                        )),
//                  )
//                      : SliverFillRemaining(
//                      child: Container(
//                        child: AnimatedList(
//                            reverse: true,
//                            key: animatedListKey,
//                            initialItemCount: comments.length,
//                            itemBuilder: (context, index, animation) {
//                              var commentDTO = CommentDTO.fromJson(
//                                  comments[index]);
//
//                              var prevComment = commentDTO;
//
//                              bool showDate = false;
//                              if (index != 0) {
//                                prevComment = CommentDTO.fromJson(
//                                    comments[index - 1]);
//                                var day = DateUtils.getTimeStamp(
//                                    commentDTO.createdAt);
//
//                                if (day !=
//                                    DateUtils.getTimeStamp(
//                                        prevComment.createdAt)) {
////                                            print(
////                                                'day = $day | prev = ${DateUtils.getTimeStamp(prevComment.updatedAt)}');
//
//                                  showDate = true;
////                                            if (!dates.contains(day)) {
////                                              dates.add(day);
////                                              showDate = true;
////                                            }
//                                }
//                              }
//
//                              return SizeTransition(
////                                                  key: ValueKey&lt;int>(index),
//                                  axis: Axis.vertical,
//                                  sizeFactor: animation,
//                                  child: Column(
//                                    mainAxisSize: MainAxisSize.min,
//                                    children: <Widget>[
//                                      CommentListItems(
//                                          commentDTO, appState,
//                                          replyClicked:
//                                              (CommentDTO comment) {
//                                            setState(() {
//                                              reply = comment;
//                                            });
//                                          }, reportClicked:
//                                          (CommentDTO comment) {
//                                        showDialog(
//                                            context: context,
//                                            builder: (context) =>
//                                                ReportCommentDialog(
//                                                    onSubmit: (String
//                                                    message) {
//                                                      reportComment(
//                                                          comment.id,
//                                                          message);
//                                                      Navigator.pop(
//                                                          context);
//                                                    }));
//                                      }, like: (comment) {
//                                        if (comment.liked) {
//                                          unlikeComment(comment.id);
//                                        } else {
//                                          likeComment(comment.id);
//                                        }
//                                      }),
//                                      showDate
//                                          ? Row(
//                                        children: <Widget>[
//                                          Expanded(
//                                              child: _line),
//                                          Text(
//                                              "${DateUtils.getDate(prevComment.createdAt)}"),
//                                          Expanded(
//                                              child: _line),
//                                        ],
//                                      )
//                                          : SizedBox(),
//                                    ],
//                                  ));
//                            }),
//                      ))
//
////                  SliverList(
////                                  delegate: SliverChildBuilderDelegate(
////                                      (context, index) => CommentListItems(
////                                              CommentDTO.fromJson(
////                                                  comments[index]),
////                                              appState, replyClicked:
////                                                  (CommentDTO comment) {
////                                            setState(() {
////                                              reply = comment;
////                                            });
////                                          }, reportClicked:
////                                                  (CommentDTO comment) {
////                                            showDialog(
////                                                context: context,
////                                                builder: (context) =>
////                                                    ReportCommentDialog(
////                                                        onSubmit:
////                                                            (String message) {
////                                                      reportComment(
////                                                          comment.id, message);
////                                                      Navigator.pop(context);
////                                                    }));
////                                          }, like: (comment) {
////                                            if (comment.liked) {
////                                              unlikeComment(comment.id);
////                                            } else {
////                                              likeComment(comment.id);
////                                            }
////                                          }),
////                                      childCount: comments.length)),
//                ],
//              ),
//            ),
//            Material(
//              color: Colors.white,
//              elevation: 4.0,
//              child: Container(
//                width: double.maxFinite,
//                child: SafeArea(
//                    top: false,
//                    child: Padding(
//                      padding: const EdgeInsets.all(16.0),
//                      child: isMember
//                          ? commentLayout()
//                          : EButton(label: "Join Room", onTap: joinRoom),
//                    )),
//              ),
//            ),
//          ],
//        ),
//        Positioned(
//            bottom: 100,
//            right: 16,
//            child: isVentTheSteam || !isMember
//                ? SizedBox()
//                : FloatingActionButton(
//                onPressed: () {
//                  _fabClicked(context);
//                },
//                child: Icon(Icons.add),
//                mini: true)),
//      ],
//    );
//  }
//
//
//  Widget _buildCustomScrollView(BuildContext context, List commentList,
//      {bool loading = false, bool error = false, VoidCallback refetch}) {
//    this.refetch = refetch;
//
//  }
//
//}
