import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';

class TopicDTO {
  var approved; //": true,
  var id; //": "5f1c75ff4a2e612c906027ad",
  var type; //": "ad",
  var createdById; //": "5f05cdd1f3fb5015c7fad5b4",
  var createdByType; //": "a",
  var description; //": "Education in Nigeria",
  var title; //": "EDUCATION",
  var createdAt; //": "2020-07-19T16:52:30.991Z",
  var updatedAt; //": "2020-07-25T18:21:21.348Z",
  var __v; //": 0

  TopicDTO.fromMap(Map<dynamic, dynamic> data) {
    approved = data["approved"];
    id = data["_id"];
    type = data["type"];
    createdById = data["createdById"];
    createdByType = data["createdByType"];
    description = data["description"];
    title = data["title"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
  }
//
//  TopicDTO.fromVoting(Map<dynamic, dynamic> data)
//      : id = data['_id'],
//        title = data['title'],
//        voteId = data['voteId'],
//        startedDate = data['startedDate'],
//        description = data['description'];
}
