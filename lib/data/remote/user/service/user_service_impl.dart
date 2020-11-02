import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';
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

      var response =
          await http.post(url, headers: header, body: json.encode(payload));

      // print(response.body);

      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return AuthResponseDTO.fromMap(decode['data']);
      }
      throw Exception(handleError(decode));
    } catch (err) {
      throw err;
    }
  }

  Future<UserProfileDTO> fetchMyProfile(token) async {
    try {
      var url = "$BASE_URL/accounts/me";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      // print(url);
      // print(header);

      var response = await http.get(url, headers: header);

      // print(response.body);
      // print(response.statusCode);
      var decode = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserProfileDTO.fromMap(decode['data']);
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
        "x-access-token": "Bearer $token"
      };

//      print(header);
//       print(data);

      var response = await http.post(url,
          headers: header, body: json.encode({"update": data}));

      // print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future updateProfile(token, data, {File avatar}) async {
    try {
      var url = "$BASE_URL/accounts/update-account";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers.addAll(headers);
      request.fields['update'] = json.encode(data);

      if (avatar != null) {
        request.files.add(http.MultipartFile(
            'avatar', avatar.readAsBytes().asStream(), avatar.lengthSync(),
            filename: avatar.path.split("/").last));
      }
      var response = await http.Response.fromStream(await request.send());
//      print('Response ${response.body}');
//       print('Status code ${response.statusCode}');
//
//       print(response.body);
      // final body = json.decode(response.body);

//      print(header);
//      print(url);
//
//      var response = await http.put(url,
//          headers: header, body: json.encode({"update": data}));

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future changeStateOfResidence(token, data) async {
    try {
      var url = "$BASE_URL/accounts/change-residence";
      var headers = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var response = await http.post(url,
          headers: headers, body: json.encode({"update": data}));

      // final body = json.decode(response.body);

      // print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
//        return AuthResponseDTO.fromMap(decode['data']);

      } else {
        if (decode['message'] != null) {
          return decode['message'];
        }

        return 'Account updated';
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future changePassword(token, {oldPassword, newPassword}) async {
    try {
      var url = "$BASE_URL/accounts/update-password";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var data = {"oldPassword": oldPassword, "newPassword": newPassword};

      var response =
          await http.put(url, headers: header, body: json.encode(data));

      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future forgotPassword(email) async {
    try {
      var url = "$BASE_URL/auth/forgot-password";
      var header = {
        "Content-Type": "application/json",
      };

      var data = {"email": email};

      var response =
          await http.post(url, headers: header, body: json.encode(data));

      // print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<AuthResponseDTO> socialAuth(accessToken, isGoogle) async {
    try {
      var url = isGoogle ? "$BASE_URL/auth/google" : "$BASE_URL/auth/facebook";
      var header = {
        "Content-Type": "application/json",
      };

      var data = {"access_token": accessToken};

      var response =
          await http.post(url, headers: header, body: json.encode(data));

      // print(response.body);
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
  sendFeedback(token, {String message, firstName, lastName, email}) async {
    try {
      var url = "$BASE_URL/home/contact-us";
      var header = {
        "Content-Type": "application/json",
        "x-access-token": "Bearer $token"
      };

      var data = {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "message": email
      };

      var response =
          await http.post(url, headers: header, body: json.encode(data));

      // print(response.body);
      var decode = json.decode(response.body);
      if (response.statusCode != 200) {
        throw Exception(handleError(decode));
      }
    } catch (err) {
      throw err;
    }
  }
}
