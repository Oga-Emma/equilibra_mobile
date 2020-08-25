import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/core/res/palet.dart';
import 'package:equilibra_mobile/ui/core/utils/svg_icon_utils.dart';
import 'package:flutter/material.dart';
import 'package:helper_widgets/empty_space.dart';

class TopicTitle extends StatelessWidget {
  TopicTitle({this.room, this.isVentTheSteam});

  RoomDTO room;
  bool isVentTheSteam;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 32.0, right: 24.0, top: 8.0, bottom: 8.0),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 48.0, right: 16.0, top: 16.0, bottom: 16.0),
                child: isVentTheSteam
                    ? Text("\n${room.currentTopic?.description ?? ""}\n")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Topic for Discussion: ",
                                style: TextStyle(
                                    fontSize: 12, color: Pallet.primaryColor)),
                            TextSpan(
                                text: room.currentTopic == null
                                    ? "No topic"
                                    : "${room.currentTopic.title}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black))
                          ])),
                          EmptySpace(),
                          room.currentTopic == null
                              ? SizedBox()
                              : Text(
                                  "${room.currentTopic.description}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                          EmptySpace(),
                          Container(
                              height: 0.5,
                              width: double.maxFinite,
                              color: Colors.grey[700]),
                          EmptySpace(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SvgIconUtils.getSvgIcon(SvgIconUtils.HON),
                              EmptySpace(),
                              Text("N/A")
//                              Text(
//                                  "${room.government == null ? '' : room.government}")
                            ],
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
}
