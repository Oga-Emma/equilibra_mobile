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
  Future createComment(
      {List<File> images,
      String comment,
      String topicId,
      String roomId}) async {
    return roomService.createComment(await localCache.getToken(),
        comment: comment, images: images, topicId: topicId, roomId: roomId);
  }

  @override
  Future deleteComment({commentId}) async {
    return roomService.deleteComment(await localCache.getToken(),
        commentId: commentId);
  }

  @override
  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId}) async {
    return roomService.fetchComments(await localCache.getToken(),
        limit: limit, roomId: roomId, topicId: topicId);
  }

  @override
  Future likeComment({commentId}) async {
    return roomService.likeComment(await localCache.getToken(),
        commentId: commentId);
  }

  @override
  Future replyComment({List<File> images, String comment, commentId}) async {
    return roomService.replyComment(await localCache.getToken(),
        images: images, comment: comment, commentId: commentId);
  }

  @override
  Future reportComment({String report, commentId}) async {
    return roomService.reportComment(await localCache.getToken(),
        report: report, commentId: commentId);
  }

  @override
  Future unlikeComment({commentId}) async {
    return roomService.unlikeComment(await localCache.getToken(),
        commentId: commentId);
  }

  @override
  Future changeTopic({title, description}) {
    // TODO: implement changeTopic
    throw UnimplementedError();
  }

  @override
  Future suggestTopic({title, description}) {
    // TODO: implement suggestTopic
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

  @override
  Future joinRoom(roomId) async {
    return roomService.joinRoom(await localCache.getToken(), roomId: roomId);
  }

  @override
  Future leaveRoom(roomId) async {
    return roomService.leaveRoom(await localCache.getToken(), roomId: roomId);
  }
}
