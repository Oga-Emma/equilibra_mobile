import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/model/dto/topic_dto.dart';

class VoteDTO {
  var id;
  RoomDTO roomId;
  TopicDTO topicId;
  var isClosed;
  var stopAt;
  List voters;
  List poorVotes;
  List notAcceptableVotes;
  List challengesVotes;
  List commendableVotes;
  List excellentVotes;
  List upVotes;
  List downVotes;
  var status;

  VoteDTO.fromMap(Map<dynamic, dynamic> data) {
    id = data['_id'];
//    print(data['voters']);
    if (data['roomId'] != null) {
      roomId = RoomDTO.fromMap(data['roomId']);
    }
    if (data['topicId'] != null) {
      topicId = TopicDTO.fromMap(data['topicId']);
    }
    isClosed = data['isClosed'] ?? true;
    stopAt = data['stopAt'];
    voters = data['voters'] ?? [];
    poorVotes = data['poorVotes'] ?? [];
    notAcceptableVotes = data['notAcceptableVotes'] ?? [];
    challengesVotes = data['challengesVotes'] ?? [];
    commendableVotes = data['commendableVotes'] ?? [];
    excellentVotes = data['excellentVotes'] ?? [];
    upVotes = data['upVotes'] ?? [];
    downVotes = data['downVotes'] ?? [];
    status = data['status'];
  }
}

class VoteTypes {
  static const String DISCUSSION = 'discussion';
  static const String CHANGE_TOPIC = 'change-topic';
}

class VoteValues {
  static const String UP_VOTE = 'upVotes';
  static const String DOWN_VOTE = 'downVotes';
  static const String POOR_VOTE = 'poorVotes';
  static const String NOT_ACCEPTABLE_VOTE = 'notAcceptableVotes';
  static const String CHALLENGE_VOTE = 'challengesVotes';
  static const String COMMENDABLE_VOTE = 'commendableVotes';
  static const String EXCELLENT_VOTE = 'excellentVotes';
}

/*
poorVotes poorVotes
notAcceptableVotes notAcceptableVotes
upVotes upVotes
downVotes downVotes
challengesVotes challengesVotes
commendableVotes commendableVotes
excellentVotes excellentVotes
 */
