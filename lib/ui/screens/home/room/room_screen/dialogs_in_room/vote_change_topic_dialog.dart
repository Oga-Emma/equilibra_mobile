import 'package:equilibra_mobile/di/controllers/room_controller.dart';
import 'package:equilibra_mobile/model/dto/vote_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:helper_widgets/date_utils/date_utils.dart';
import 'package:helper_widgets/empty_space.dart';
import 'package:helper_widgets/error_handler.dart';
import 'package:provider/provider.dart';

class VoteChangeTopicDialog extends StatefulWidget {
  VoteChangeTopicDialog(this.voteId, this.title, this.description,
      {this.autoVote = false, this.stopAt});
  String voteId;
  String title;
  String description;
  bool autoVote;
  DateTime stopAt;

  @override
  _VoteChangeTopicDialogState createState() => _VoteChangeTopicDialogState();
}

class _VoteChangeTopicDialogState extends State<VoteChangeTopicDialog>
    with ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  bool voted = false;

  @override
  void initState() {
    if (widget.autoVote) {
      Future.delayed(
          Duration.zero, () => requestTopicChange(VoteValues.UP_VOTE));
    }
    super.initState();
  }

  RoomController controller;
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<RoomController>(context);
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        contentPadding: EdgeInsets.all(0),
        content: voted ? votedField() : votingField());
  }

  Widget oldTopic() {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            margin:
                EdgeInsets.only(left: 32.0, right: 24.0, top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(4.0)),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 48.0, right: 16.0, top: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Topic Discussion: ",
                          style: TextStyle(
                              fontSize: 12, color: Pallet.primaryColor)),
                      TextSpan(
                          text: "${widget.title}".toUpperCase(),
                          style: TextStyle(fontSize: 12, color: Colors.black))
                    ])),
                    EmptySpace(),
                    Text(
                      "${widget.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
//                                border: Border.all(color: Colors.white)
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: SizedBox(
              child: Center(
                child: Card(
                  elevation: 8.0,
                  child: Container(
                    height: 65,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image(
                          image: AssetImage(
                              "assets/img/room_topic_side_image.png")),
                    ),
                    decoration: BoxDecoration(
//                                border: Border.all(color: Colors.white)
//                                          color: Colors.yellow,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  requestTopicChange(String vote) async {
    try {
      await controller.voteTopicChange(widget.voteId, vote);
      setState(() {
        voted = true;
      });
    } catch (err) {
      showErrorToast(getErrorMessage(err));
    }
  }

  votedField() {
    var time = Duration(seconds: 5); //DateTime.now().difference(widget.stopAt);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Pallet.primaryColor, width: 2),
                ),
                child: Center(
                  child: StreamBuilder<int>(
                      stream: Stream.periodic(Duration(seconds: 1),
                          (value) => time.inSeconds - value),
                      initialData: 120,
                      builder: (context, snapshot) {
                        if (snapshot.data <= 1) {
                          Future.delayed(
                              Duration.zero, () => Navigator.pop(context));
                        }
                        return Text(
                            '${_printDuration(Duration(seconds: snapshot.data))}');
                      }),
                ),
              ),
            ],
          ),
          EmptySpace(multiple: 2),
          Container(
            padding: EdgeInsets.all(16),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(color: Pallet.primaryColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Voting for new topic is in progress',
                  style: TextStyle(
                      color: Pallet.primaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 14),
                ),
                EmptySpace(multiple: 2),
                Text(
                  'Suggested Topic:',
                  style: TextStyle(fontSize: 14),
                ),
                EmptySpace(multiple: 3),
                Text('${widget.title}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                EmptySpace(multiple: 0.5),
                Text('${widget.description}',
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                EmptySpace(multiple: 3),
                Row(
                  children: <Widget>[
                    Icon(Icons.check, size: 20, color: Pallet.primaryColor),
                    EmptySpace(),
                    Text(
                      'Your vote has been registered',
                      style:
                          TextStyle(color: Pallet.primaryColor, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
//    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  votingField() {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            EmptySpace(multiple: 3),
            Center(
              child: Text("VOTE CHANGE TOPIC",
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: Pallet.accentColor, fontWeight: FontWeight.bold)),
            ),
            EmptySpace(),
            oldTopic(),
            EmptySpace(multiple: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 42,
                      child: FlatButton(
                          color: Pallet.primaryColor,
                          onPressed: controller.isBusy
                              ? null
                              : () {
//                              Navigator.pop(context, true);
                                  requestTopicChange("up");
                                },
                          child: Center(
                            child: Text(
                              "ACCEPT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ))),
                  EmptySpace(multiple: 2),
                  SizedBox(
                      height: 42,
                      child: OutlineButton(
                          borderSide: BorderSide(
                            color: Pallet.primaryColor,
                          ),
                          onPressed: controller.isBusy
                              ? null
                              : () {
//                              Navigator.pop(context, false);
                                  requestTopicChange("down");
                                },
                          child: Center(
                            child: Text(
                              "DECLINE",
                              style: TextStyle(color: Pallet.primaryColor),
                            ),
                          ))),
                  EmptySpace(multiple: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
