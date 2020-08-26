import 'package:equilibra_mobile/model/dto/_voting_dtos.dart';
import 'package:equilibra_mobile/model/dto/topic_dto.dart';
import 'package:equilibra_mobile/model/dto/vote_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class EndOfTopicVotingDialog extends StatefulWidget {
  EndOfTopicVotingDialog(this.topic, this.voteId);
  TopicDTO topic;
  var voteId;

  @override
  _EndOfTopicVotingDialogState createState() => _EndOfTopicVotingDialogState();
}

class _EndOfTopicVotingDialogState extends State<EndOfTopicVotingDialog> {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  int selectedIndex = 0;

  List<Option> options = [
    Option(
        0, "Poor, not fit for purpose - Change Required", VoteValues.POOR_VOTE),
    Option(1, "Not acceptable - Urgent Improvement Required",
        VoteValues.NOT_ACCEPTABLE_VOTE),
    Option(
        2, "Challenges - But Improvement Required", VoteValues.CHALLENGE_VOTE),
    Option(3, "Commendable - Service Level", VoteValues.COMMENDABLE_VOTE),
    Option(4, "Excellent or Outstanding - Service Level",
        VoteValues.EXCELLENT_VOTE),
  ];

  @override
  Widget build(BuildContext context) {
//    print("ROOM ID => ${widget.room.id}");
//    print("ROOM ID => ${widget.appState.token}");

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EmptySpace(multiple: 3),
              Center(
                child: Text("VOTE",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Pallet.accentColor,
                        fontWeight: FontWeight.bold)),
              ),
              EmptySpace(multiple: 2),
//              Center(
//                child: Container(
//                  padding: EdgeInsets.all(8.0),
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      SvgIconUtils.getSvgIcon(SvgIconUtils.CLOCK,
//                          color: Pallet.accentColor, height: 18, width: 18),
//                      EmptySpace(),
//                      Text(
//                        "${widget.topic.startedDate}",
////                                              "5 Day(s) 15 Hours 56 Minutes",
//                        style: Theme.of(context)
//                            .textTheme
//                            .caption
//                            .copyWith(color: Pallet.accentColor),
//                      )
//                    ],
//                  ),
//                  decoration: BoxDecoration(
//                      border: Border.all(color: Pallet.accentColor)),
//                ),
//              ),
//              EmptySpace(),
              oldTopic(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                    Text("NEW TOPIC",
//                        style: Theme.of(context).textTheme.caption.copyWith(
//                            color: Colors.black, fontWeight: FontWeight.bold)),
                      Column(
                        children: <Widget>[]..addAll(List.generate(
                            options.length,
                            (index) => _option(options[index].title, index))),
                      ),
                      EmptySpace(multiple: 2),
                      _sending
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 42,
                              child: EButton(label: "Vote", onTap: vote)),
                      EmptySpace(multiple: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                          text: "${widget.topic.title}".toUpperCase(),
                          style: TextStyle(fontSize: 12, color: Colors.black))
                    ])),
                    EmptySpace(),
                    Text(
                      "${widget.topic.description}",
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

  String topic;
  String description;
  bool _sending = false;
  vote() async {}

  _option(String label, int index) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: index == selectedIndex
                  ? Pallet.primaryColor
                  : Colors.transparent)),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: index == selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = index;
                    });
                  }),
              Expanded(
                child: Text(
                  "$label",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
