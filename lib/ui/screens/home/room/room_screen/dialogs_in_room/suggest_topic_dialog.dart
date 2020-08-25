import 'package:equilibra_mobile/input_validators.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/widgets/e_button.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class SuggestTopicDialog extends StatefulWidget {
  SuggestTopicDialog(this.room);
  RoomDTO room;
  @override
  _SuggestTopicDialogState createState() => _SuggestTopicDialogState();
}

class _SuggestTopicDialogState extends State<SuggestTopicDialog> {
  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
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
                child: Text("SUGGEST TOPIC",
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: Pallet.accentColor,
                        fontWeight: FontWeight.bold)),
              ),
              EmptySpace(),
              widget.room.currentTopic == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "This room has no topic",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    )
                  : oldTopic(),
              EmptySpace(multiple: 2),
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
                      EmptySpace(),
                      TextFormField(
                        maxLines: 1,
                        validator: InputValidators.validateString,
                        onSaved: (value) {
//                          print(value);
                          this.topic = value;
                        },
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Enter new topic",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(4.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(4.0))),
                      ),
                      EmptySpace(multiple: 2),
//                    Text("TOPIC DESCRIPTION",
//                        style: Theme.of(context).textTheme.caption.copyWith(
//                            color: Colors.black, fontWeight: FontWeight.bold)),
//                    EmptySpace(),
                      TextFormField(
                        maxLines: 5,
                        validator: InputValidators.validateString,
                        onSaved: (value) {
//                          print(value);
                          this.description = value;
                        },
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Topic description",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(4.0)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(4.0))),
                      ),
                      EmptySpace(multiple: 2),
                      SizedBox(
                          height: 42,
                          child: EButton(
                              label: "Suggest Topic",
                              onTap: requestTopicChange)),
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
                          text: "HEALTH",
                          style: TextStyle(fontSize: 12, color: Colors.black))
                    ])),
                    EmptySpace(),
                    Text(
                      "Some random \ntext",
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

  requestTopicChange() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
