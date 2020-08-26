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
  Future createComment(token,
      {List<File> images,
      String comment,
      String topicId,
      String roomId}) async {
    try {
      var url = "$BASE_URL/comments/save-comment";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);
      request.fields['comment'] =
          json.encode({"comment": comment, "topic": topicId, "room": roomId});

      if (images != null && images.isNotEmpty) {
        request.files.addAll(images.map((e) => http.MultipartFile(
            'images', e.readAsBytes().asStream(), e.lengthSync(),
            filename: e.path.split("/").last)));
      }
      var response = await http.Response.fromStream(await request.send());
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future deleteComment(token, {commentId}) async {
    try {
      var url = "$BASE_URL/comments/$commentId";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.delete(url, headers: headers);

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<List<CommentDTO>> fetchComments(token,
      {page = 1, limit = 100, roomId, topicId}) async {
    try {
      var url = "$BASE_URL/comments/$page/$limit/$roomId/$topicId";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
//        return [];
        return List<CommentDTO>.from((decode['data']['comments'] ?? [])
            .map((e) => CommentDTO.fromJson(e))
            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Future likeComment(token, {commentId}) async {
    try {
      var url = "$BASE_URL/comments/like/$commentId";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.patch(url, headers: headers);

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future replyComment(token,
      {List<File> images, String comment, commentId}) async {
    try {
      var url = "$BASE_URL/comments/reply-comment";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers.addAll(headers);
      request.fields['comment'] =
          json.encode({"comment": comment, "commentId": commentId});

      if (images != null && images.isNotEmpty) {
        request.files.addAll(images.map((e) => http.MultipartFile(
            'images', e.readAsBytes().asStream(), e.lengthSync(),
            filename: e.path.split("/").last)));
      }
      var response = await http.Response.fromStream(await request.send());

      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future reportComment(token, {String report, commentId}) async {
    try {
      var url = "$BASE_URL/comments/report-comment";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

//      print(report);
//      print(commentId);

      var response = await http.patch(url,
          headers: headers,
          body: json.encode({"report": report, "comment": commentId}));

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future suggestTopic(token, {title, description}) {
    // TODO: implement suggestTopic
    throw UnimplementedError();
  }

  @override
  Future unlikeComment(token, {commentId}) async {
    try {
      var url = "$BASE_URL/comments/unlike/$commentId";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.patch(url, headers: headers);

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
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
