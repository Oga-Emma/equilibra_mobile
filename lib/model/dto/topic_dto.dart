import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';

class TopicDTO {
  /*
  _id: darangiGraphId
title: String
closeDate: String
startDate: String
votes: [String]
rooms: [roomType]
isClosed: Boolean
description: String
createdBy: user
   */

  var id;
  String title;
  String voteId;
  String roomId;
  String closeDate;
  String startDate;
  List<dynamic> votes;
  List<RoomDTO> rooms;
  bool isClosed;
  String description;
  var startedDate;
  UserDTO createdBy;

  TopicDTO.fromMap(Map<dynamic, dynamic> data) {
//    print("Topic > $data");
    id = data['_id'];
    closeDate = data['closeDate'];
    voteId = data['voteId'];
    roomId = data['roomId'];
    startDate = data['startDate'];
    votes = data['votes'];
    title = data['title'];
    startedDate = data['startedDate'];
//        rooms = data['rooms'],
    isClosed = data['isClosed'];
    description = data['description'];
//        createdBy = UserDTO.fromMap(data['createdBy'] ?? {});
  }

  TopicDTO.fromVoting(Map<dynamic, dynamic> data)
      : id = data['_id'],
        title = data['title'],
        voteId = data['voteId'],
        startedDate = data['startedDate'],
        description = data['description'];
}
