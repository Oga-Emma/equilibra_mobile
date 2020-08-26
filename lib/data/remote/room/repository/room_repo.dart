import 'dart:io';

import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class RoomRepo {
  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId});
  Future createComment(
      {List<File> images, String comment, String topicId, String roomId});
  Future replyComment({List<File> images, String comment, commentId});
  Future reportComment({String report, commentId});

  Future likeComment({commentId});
  Future unlikeComment({commentId});
  Future deleteComment({commentId});

  Future suggestTopic({title, description});
  Future changeTopic({title, description});
  Future voteTopicChange({voteId, vote});
  Future voteEndOfDiscussionPoll({voteId, vote});
}
