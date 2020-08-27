import 'dart:io';

import 'package:equilibra_mobile/model/dto/admin_notification.dart';
import 'package:equilibra_mobile/model/dto/advert_dto.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class RoomService {
  Future<List<CommentDTO>> fetchComments(token, {page, limit, roomId, topicId});
  Future createComment(token,
      {List<File> images, String comment, String topicId, String roomId});
  Future replyComment(token, {List<File> images, String comment, commentId});
  Future reportComment(token, {String report, commentId});

  Future likeComment(token, {commentId});
  Future unlikeComment(token, {commentId});
  Future deleteComment(token, {commentId});

  Future joinRoom(token, {roomId});
  Future leaveRoom(token, {roomId});

  Future suggestTopic(token, {title, description, roomId});
  Future changeTopic(token, {title, description, roomId});
  Future voteTopicChange(token, {voteId, vote});
  Future voteEndOfDiscussionPoll(token, {voteId, vote});

  Future<List<AdvertDTO>> fetchRoomAdvert(token,
      {page, limit, roomId, visibility});
  Future<AdminNotificationDTO> fetchAdminNotification(token, {roomId, userId});
  Future muteAdminNotification(token, {notificationId, userId});
}
