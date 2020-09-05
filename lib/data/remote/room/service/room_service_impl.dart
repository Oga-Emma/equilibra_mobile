import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/model/dto/admin_notification.dart';
import 'package:equilibra_mobile/model/dto/advert_dto.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:http/http.dart' as http;

import 'room_service.dart';
export 'room_service.dart';

class RoomServiceImpl with BaseApi implements RoomService {
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
  Future voteEndOfDiscussionPoll(token, {voteId, vote}) async {
    try {
      var url = "$BASE_URL/topics/vote-discussion/$voteId/$vote";

      print(url);
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.patch(url, headers: headers);

      print("vote end of discussion poll => ${response.body}");
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future changeTopic(token, {title, description, roomId}) async {
    try {
      var url = "$BASE_URL/topics/set-topic";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var payLoad = {
        "title": title,
        "description": description,
        "room": roomId
      };
      var response = await http.post(url,
          headers: headers, body: json.encode({"topicPayload": payLoad}));

      print("Set topic => ${response.body}");
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future suggestTopic(token, {title, description, roomId}) async {
    try {
      var url = "$BASE_URL/topics/suggest";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var payload = {
        "title": title,
        "description": description,
        "room": roomId
      };

      print(payload);
      var response = await http.post(url,
          headers: headers, body: json.encode({"topicPayload": payload}));

      print("Suggest topic => ${response.body}");

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future voteTopicChange(token, {voteId, vote}) async {
    try {
      var url = "$BASE_URL/topics/vote-topic-change/$voteId/$vote";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      print(url);

      var response = await http.patch(url, headers: headers);

      print("Topic change => ${response.body}");
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future joinRoom(token, {roomId}) async {
    try {
      var url = "$BASE_URL/rooms/join/$roomId";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.patch(url, headers: headers);

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
  Future leaveRoom(token, {roomId}) async {
    try {
      var url = "$BASE_URL/rooms/leave/$roomId";
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
  Future<AdminNotificationDTO> fetchAdminNotification(token,
      {roomId, userId}) async {
    try {
      var url = "$BASE_URL/adverts/notifications/$roomId/$userId";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

//      print(token);
//      print(url);

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return AdminNotificationDTO.fromMap(decode['data']);
//        return [];
//        return List<CommentDTO>.from((decode['data']['comments'] ?? [])
//            .map((e) => CommentDTO.fromJson(e))
//            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Future<List<AdvertDTO>> fetchRoomAdvert(token,
      {page, limit, roomId, visibility}) async {
    try {
      var url =
          "$BASE_URL/home/${page ?? 1}/${limit ?? 10}/$roomId/${visibility ?? "room"}";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

//      print(token);
//      print(url);

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
//        return [];
        return List<AdvertDTO>.from((decode['data']['adverts'] ?? [])
            .map((e) => AdvertDTO.fromMap(e))
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
  Future muteAdminNotification(token, {notificationId, userId}) async {
    try {
      var url = "$BASE_URL/adverts/mute-notification/$notificationId/$userId";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.patch(url, headers: headers);
      print(response.body);

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
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
