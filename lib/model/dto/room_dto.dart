import 'package:equilibra_mobile/model/dto/filterable_list_item.dart';
import 'package:equilibra_mobile/model/dto/topic_dto.dart';

class RoomDTO extends FilterableListItem {
  var changeTopic; //": false,
  var id; //": "5e3d4a47fb9e016690a5bbc4",
  var roomType; //": "VTS",
  var government; //": null,
  var name; //": "Vent The Steam",
  TopicDTO currentTopic;
  List<RoomMember> members;
  var createdAt; //-02-07T11:30:15.797Z",
  var updatedAt; //-08-25T10:06:52.791Z",
  var slug; //-The-Steam",
  var __v; //
  var topicStartDate; //-07-25T18:12:15.254Z",
  var voteId; //"

  RoomDTO.fromMap(Map<String, dynamic> data) {
    changeTopic = data["changeTopic"] ?? false;
    id = data["_id"];
    roomType = data["roomType"];
    government = data["government"];
    name = data["name"];
    slug = data["slug"];
    members = List<RoomMember>.from(
        (data["members"] ?? []).map((e) => RoomMember.fromMap(e)).toList());
    __v = data["__v"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    if (data["currentTopic"] != null) {
      currentTopic = TopicDTO.fromMap(data["currentTopic"]);
    }
    topicStartDate = data["topicStartDate"];
  }
}

class RoomGroupDTO {
  String groupName;
  String roomType;
  String title;
  bool isFederal;
  bool isOrigin;
  bool ventTheSteam;
  int numberOfGroups;

  String roomId;
  String description1;
  String description2;

  RoomGroupDTO(this.groupName, this.roomType, this.title, this.numberOfGroups,
      {this.isOrigin = false,
      this.isFederal = false,
      this.ventTheSteam = false,
      this.roomId,
      this.description1 = "",
      this.description2 = ""});
}

class RoomType {
  static const String HOUSE_OF_REPRESENTATIVE = "HOR";
  static const String HOUSE_OF_ASSEMBLY = "HOA";
  static const String SENATE = "SENATE";
  static const String MINISTRY = "MINISTRY";
  static const String COURT = "COURT";
  static const String LGA = "LGA";
}

class RoomMember {
  //            {
//                "moderatorType": "Member",
//                "_id": "5f1c75bb4a2e612c906027ac",
//                "member": "5f1c640b4a2e612c906026e6"
//            },
  String member;
  String id;
  String moderatorType;
  RoomMember.fromMap(Map<dynamic, dynamic> data) {
    member = data['member'];
    id = data['_id'];
    moderatorType = data['moderatorType'];
  }
}
