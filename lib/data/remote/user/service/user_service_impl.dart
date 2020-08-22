import 'dart:convert';
import 'dart:math';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:http/http.dart' as http;

import 'user_service.dart';
export 'user_service.dart';

class UserServiceImpl with BaseApi implements UserService {
  @override
  Future createAccount(
      {birthMonth,
      birthYear,
      currentCountry,
      email,
      fullName,
      password,
      username}) async {
    try {
      var payload = {
        "username": username,
        "password": password,
        "email": email,
        "fullName": fullName,
        "birthMonth": birthMonth,
        "birthYear": birthYear,
        "currentCountry": currentCountry
      };

      var url = "$BASE_URL/auth/signup";
      var header = {"Content-Type": "application/json"};

      var response =
          await http.post(url, headers: header, body: json.encode(payload));

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
  Future<AuthResponseDTO> login({email, password}) async {
    try {
      var payload = {"password": password, "username": email};

      var url = "$BASE_URL/auth/login";
      var header = {"Content-Type": "application/json"};

      print(payload);
      var response =
          await http.post(url, headers: header, body: json.encode(payload));

//      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return AuthResponseDTO.fromMap(decode['data']);
      }
      throw Exception(handleError(decode));
    } catch (err) {
      throw err;
    }
  }

  @override
  Future completeSignup(token, data) async {
    try {
      var url = "$BASE_URL/accounts/continue-signup";
      var header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      };

      print(header);
      print(data);

      var response = await http.post(url,
          headers: header, body: json.encode({"update": data}));

      print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
//        return AuthResponseDTO.fromMap(decode['data']);

      }
      throw Exception(handleError(decode));
    } catch (err) {
      throw err;
    }
  }
}
