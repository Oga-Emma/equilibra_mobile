import 'package:equilibra_mobile/model/dto/filterable_list_item.dart';

class RoomDTO extends FilterableListItem {
  var changeTopic; //": false,
  var id; //": "5e3d4a48fb9e016690a5be9c",
  var roomType; //": "LGA",
  var government; //": "5e3d4a46fb9e016690a5b898",
  var name; //": "Abia North",
  var slug; //": "abia-north",
  var members; //": [],
  var __v; //": 0,
  var createdAt; //": "2020-02-07T11:30:18.585Z",
  var updatedAt; //": "2020-07-08T14:25:59.071Z",
  var currentTopic; //": null,
  var topicStartDate; //": null,
  var schedules; //": 0

  RoomDTO.fromMap(Map<String, dynamic> data) {
    changeTopic = data["changeTopic"] ?? false;
    id = data["_id"];
    roomType = data["roomType"];
    government = data["government"];
    name = data["name"];
    slug = data["slug"];
    members = data["members"];
    __v = data["__v"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    currentTopic = data["currentTopic"];
    topicStartDate = data["topicStartDate"];
    schedules = data["schedules"];
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
  String member;
  bool moderator;
  String moderatorType;
  RoomMember.fromMap(Map<dynamic, dynamic> data) {
    member = data['member'];
    moderator = data['moderator'];
    moderatorType = data['moderatorType'];
  }
}
