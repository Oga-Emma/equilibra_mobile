import 'dart:convert';
import 'dart:math';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:http/http.dart' as http;

import 'data_service.dart';
export 'data_service.dart';

class DataServiceImpl with BaseApi implements DataService {
  Future<List<GovernmentDTO>> fetchGovernment() async {
    try {
      var url = "$BASE_URL/home/list-governments/5e3d4a46fb9e016690a5b896/1/40";
      var header = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<GovernmentDTO>.from((decode['data']['governments'] ?? [])
            .map((e) => GovernmentDTO.fromMap(e))
            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  Future<List<RoomDTO>> fetchHomeRoom(String type, String stateId) async {
    try {
      var url = "$BASE_URL/home/rooms/$type/$stateId/1/40";
      var header = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<RoomDTO>.from((decode['data']['rooms'] ?? [])
            .map((e) => RoomDTO.fromMap(e))
            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  Future<List<RoomDTO>> fetchRoom(String type, String stateId,
      {bool origin = false}) async {
    try {
      var url = "$BASE_URL/rooms/$type/$stateId/$origin/1/40";
      var header = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: header);

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<RoomDTO>.from((decode['data']['rooms'] ?? [])
            .map((e) => RoomDTO.fromMap(e))
            .toList());
      } else {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }
//  @override
//  Future createAccount(
//      {birthMonth,
//      birthYear,
//      currentCountry,
//      email,
//      fullName,
//      password,
//      username}) async {
//    try {
//      var payload = {
//        "username": username,
//        "password": password,
//        "email": email,
//        "fullName": fullName,
//        "birthMonth": birthMonth,
//        "birthYear": birthYear,
//        "currentCountry": currentCountry
//      };
//
//      var url = "$BASE_URL/auth/signup";
//      var header = {"Content-Type": "application/json"};
//
//      var response =
//          await http.post(url, headers: header, body: json.encode(payload));
//
//      print(response.body);
//      var decode = json.decode(response.body);
//      if (response.statusCode != 200) {
//        throw Exception(handleError(decode));
//      }
//    } catch (err) {
//      throw err;
//    }
//  }
//
//  @override
//  Future<AuthResponseDTO> login({email, password}) async {
//    try {
//      var payload = {"password": password, "username": email};
//
//      var url = "$BASE_URL/auth/login";
//      var header = {"Content-Type": "application/json"};
//
//      print(payload);
//      var response =
//          await http.post(url, headers: header, body: json.encode(payload));
//
//      print(response.body);
//      var decode = json.decode(response.body);
//      if (response.statusCode == 200) {
//        return AuthResponseDTO.fromMap(decode['data']);
//      }
//      throw Exception(handleError(decode));
//    } catch (err) {
//      throw err;
//    }
//  }
}
