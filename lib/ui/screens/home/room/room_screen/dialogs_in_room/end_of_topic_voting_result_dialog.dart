import 'package:equilibra_mobile/model/dto/_voting_dtos.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class EndOfTopicVotingResultDialog extends StatefulWidget {
  EndOfTopicVotingResultDialog(this.room, this.result);
  RoomDTO room;
  VotingResult result;

  @override
  _EndOfTopicVotingResultDialogState createState() =>
      _EndOfTopicVotingResultDialogState();
}

class _EndOfTopicVotingResultDialogState
    extends State<EndOfTopicVotingResultDialog> {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  int selectedIndex = 0;

  @override
  initState() {
    var total = widget.result.voters ?? 0;
    var max = widget.result.poorVotes;
    if (widget.result.excellentVotes > max) {
      max = widget.result.excellentVotes;
    }

    if (widget.result.votenotAcceptableVotes > max) {
      max = widget.result.votenotAcceptableVotes;
    }

    if (widget.result.challengesVotes > max) {
      max = widget.result.challengesVotes;
    }

    if (widget.result.commendableVotes > max) {
      max = widget.result.commendableVotes;
    }

    results.addAll([
      Result(0, "Poor, not fit for purpose - Change Required",
          getPercent(total, widget.result.poorVotes ?? 0),
          isHighest: widget.result.poorVotes == max),
      Result(1, "Not acceptable - Urgent Improvement Required",
          getPercent(total, widget.result.votenotAcceptableVotes ?? 0),
          isHighest: widget.result.votenotAcceptableVotes == max),
      Result(2, "Challenges - But Improvement Required",
          getPercent(total, widget.result.challengesVotes ?? 0),
          isHighest: widget.result.challengesVotes == max),
      Result(3, "Commendable - Service Level",
          getPercent(total, widget.result.commendableVotes ?? 0),
          isHighest: widget.result.commendableVotes == max),
      Result(4, "Excellent or Outstanding - Service Level",
          getPercent(total, widget.result.excellentVotes ?? 0),
          isHighest: widget.result.excellentVotes == max)
    ]);

    super.initState();
  }

  List<Result> results = [];

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
              Center(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgIconUtils.getSvgIcon(SvgIconUtils.CLOCK,
                          color: Pallet.accentColor, height: 18, width: 18),
                      EmptySpace(),
                      Text(
                        "${widget.room.currentTopic.startDate}",
//                                              "5 Day(s) 15 Hours 56 Minutes",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Pallet.accentColor),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Pallet.accentColor)),
                ),
              ),
              EmptySpace(),
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
                            results.length,
                            (index) => _result(results[index]))),
                      ),
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
                          text:
                              "${widget.room.currentTopic.title}".toUpperCase(),
                          style: TextStyle(fontSize: 12, color: Colors.black))
                    ])),
                    EmptySpace(),
                    Text(
                      "${widget.room.currentTopic.description}",
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
  requestTopicChange() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  showLoadingDialog() => showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()));

  _result(Result result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Stack(children: <Widget>[
        FractionallySizedBox(
          child: Container(
            height: 42,
            color:
                result.isHighest ? Pallet.primaryColor : Pallet.backgroundColor,
          ),
          widthFactor: result.getRatio,
        ),
        Container(
          color: Colors.transparent,
          width: double.maxFinite,
          padding: EdgeInsets.all(8.0),
          child: Text(
            "${result.result.toInt()}% ${result.title}",
            style: TextStyle(fontSize: 14),
          ),
        ),
      ]),
    );
  }
}

double getPercent(total, result) {
  if (result == null || result == 0) return 0;

  return result / total * 100;
}

class Result {
  final int index;
  final String title;
  final double result;
  final bool isHighest;
  Result(this.index, this.title, this.result, {this.isHighest = false});

  double get getRatio => result / 100;
}
