import 'dart:io';

import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service.dart';
import 'package:equilibra_mobile/data/remote/room/service/room_service.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

import 'room_repo.dart';
export 'room_repo.dart';

class RoomRepoImpl implements RoomRepo {
  LocalCache localCache;
  RoomService roomService;
  RoomRepoImpl({this.localCache, this.roomService});

  @override
  Future changeTopic({title, description}) {
    // TODO: implement changeTopic
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> createComment(token,
      {List<File> images, String comment, String topicId, String roomId}) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> deleteComment({commentId}) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId}) async {
    return roomService.fetchComments(await localCache.getToken(),
        limit: limit, roomId: roomId, topicId: topicId);
  }

  @override
  Future<CommentDTO> likeComment({commentId}) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> replyComment(token,
      {List<File> images, String comment, commentId}) {
    // TODO: implement replyComment
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> reportComment({String report, commentId}) {
    // TODO: implement reportComment
    throw UnimplementedError();
  }

  @override
  Future suggestTopic({title, description}) {
    // TODO: implement suggestTopic
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> unlikeComment({commentId}) {
    // TODO: implement unlikeComment
    throw UnimplementedError();
  }

  @override
  Future voteEndOfDiscussionPoll({voteId, vote}) {
    // TODO: implement voteEndOfDiscussionPoll
    throw UnimplementedError();
  }

  @override
  Future voteTopicChange({voteId, vote}) {
    // TODO: implement voteTopicChange
    throw UnimplementedError();
  }
}
