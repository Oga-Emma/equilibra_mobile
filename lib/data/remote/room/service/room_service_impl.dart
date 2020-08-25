import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:http/http.dart' as http;

import 'room_service.dart';
export 'room_service.dart';

class RoomServiceImpl with BaseApi implements RoomService {
  @override
  Future changeTopic(token, {title, description}) {
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
  Future<CommentDTO> deleteComment(token, {commentId}) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<List<CommentDTO>> fetchComments(token,
      {page = 1, limit = 100, roomId, topicId}) async {
    try {
      var url = "$BASE_URL/comments/$page/$limit/$roomId/$topicId";
      var header = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: header);

      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return [];
//        return List<CommentDTO>.from((decode['data']['comments'] ?? [])
//            .map((e) => RoomDTO.fromMap(e))
//            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<CommentDTO> likeComment(token, {commentId}) {
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
  Future<CommentDTO> reportComment(token, {String report, commentId}) {
    // TODO: implement reportComment
    throw UnimplementedError();
  }

  @override
  Future suggestTopic(token, {title, description}) {
    // TODO: implement suggestTopic
    throw UnimplementedError();
  }

  @override
  Future<CommentDTO> unlikeComment(token, {commentId}) {
    // TODO: implement unlikeComment
    throw UnimplementedError();
  }

  @override
  Future voteEndOfDiscussionPoll(token, {voteId, vote}) {
    // TODO: implement voteEndOfDiscussionPoll
    throw UnimplementedError();
  }

  @override
  Future voteTopicChange(token, {voteId, vote}) {
    // TODO: implement voteTopicChange
    throw UnimplementedError();
  }

//  Future<List<RoomDTO>> fetchHomeRoom(String type, String stateId) async {
//    try {
//      var url = "$BASE_URL/home/rooms/$type/$stateId/1/40";
//      var header = {"Content-Type": "application/json"};
//
//      var response = await http.get(url, headers: header);
//
////      print(response.body);
//      var decode = json.decode(response.body);
//      if (response.statusCode == 200) {
//        return List<RoomDTO>.from((decode['data']['rooms'] ?? [])
//            .map((e) => RoomDTO.fromMap(e))
//            .toList());
//      } else {
//        throw Exception(handleError(decode));
//      }
//    } catch (err) {
//      throw err;
//    }
//  }

}
