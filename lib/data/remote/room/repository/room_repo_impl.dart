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
  Future createComment(
      {List<File> images,
      String comment,
      String topicId,
      String roomId}) async {
    return roomService.createComment(await localCache.getToken(),
        comment: comment, images: images, topicId: topicId, roomId: roomId);
  }

  @override
  Future deleteComment({commentId}) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId}) async {
    return roomService.fetchComments(await localCache.getToken(),
        limit: limit, roomId: roomId, topicId: topicId);
  }

  @override
  Future likeComment({commentId}) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Future replyComment({List<File> images, String comment, commentId}) async {
    return roomService.replyComment(await localCache.getToken(),
        images: images, comment: comment, commentId: commentId);
  }

  @override
  Future reportComment({String report, commentId}) {
    // TODO: implement reportComment
    throw UnimplementedError();
  }

  @override
  Future suggestTopic({title, description}) {
    // TODO: implement suggestTopic
    throw UnimplementedError();
  }

  @override
  Future unlikeComment({commentId}) {
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
