import 'dart:io';

import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class RoomRepo {
  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId});
  Future<CommentDTO> createComment(token,
      {List<File> images, String comment, String topicId, String roomId});
  Future<CommentDTO> replyComment(token,
      {List<File> images, String comment, commentId});
  Future<CommentDTO> reportComment({String report, commentId});

  Future<CommentDTO> likeComment({commentId});
  Future<CommentDTO> unlikeComment({commentId});
  Future<CommentDTO> deleteComment({commentId});

  Future suggestTopic({title, description});
  Future changeTopic({title, description});
  Future voteTopicChange({voteId, vote});
  Future voteEndOfDiscussionPoll({voteId, vote});
}
