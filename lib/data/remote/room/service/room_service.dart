import 'dart:io';

import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class RoomService {
  Future<List<CommentDTO>> fetchComments(token, {page, limit, roomId, topicId});
  Future<CommentDTO> createComment(token,
      {List<File> images, String comment, String topicId, String roomId});
  Future<CommentDTO> replyComment(token,
      {List<File> images, String comment, commentId});
  Future<CommentDTO> reportComment(token, {String report, commentId});

  Future<CommentDTO> likeComment(token, {commentId});
  Future<CommentDTO> unlikeComment(token, {commentId});
  Future<CommentDTO> deleteComment(token, {commentId});

  Future suggestTopic(token, {title, description});
  Future changeTopic(token, {title, description});
  Future voteTopicChange(token, {voteId, vote});
  Future voteEndOfDiscussionPoll(token, {voteId, vote});
}
