import 'dart:convert';

import 'package:equilibra_mobile/model/dto/user_dto.dart';
import 'package:helper_widgets/string_utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_cache.dart';

class LocalCacheImpl implements LocalCache {
  SharedPreferences sharedPreferences;
  LocalCacheImpl({this.sharedPreferences});

  UserDTO user;
  String token;

  @override
  Future<String> getToken() async {
//    if (sharedPreferences.containsKey('token') &&
//        sharedPreferences.containsKey('time')) {
//      var timeSaved =
//      DateTime.fromMillisecondsSinceEpoch(sharedPreferences.getInt('time'));
//      if (timeSaved.isAfter(DateTime.now()) ||
//          DateTime.now().difference(timeSaved).inHours > 12) {
//        throw TokenExpiredException();
//      }
//    } else {
//      throw TokenNotFoundException();
//    }

    return sharedPreferences.getString('token');
  }

  @override
  Future<UserDTO> getUser() async {
    try {
      if (user != null) {
        return user;
      }
//      if (!(sharedPreferences.containsKey('not-first-time'))) {
//        throw FirstTimeException();
//      }

      if (!sharedPreferences.containsKey('user')) {
        throw Exception("User not found");
      }

      await getToken();

      final userStr = sharedPreferences.getString('user');
      if (StringUtils.isEmpty(userStr)) {
        throw Exception("User not found");
      }

      final userJson = json.decode(userStr);
      user = UserDTO.fromMap(userJson);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    sharedPreferences.setString('token', token);
    sharedPreferences.setInt('time', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<void> saveUser(UserDTO user) async {
//    print(user.toMap());
    return sharedPreferences.setString('user', json.encode(user.toMap()));
  }

  @override
  Future<void> clear() {
    user = null;
    return sharedPreferences.clear();
  }

  @override
  Future setNotFirstTime() async {
    sharedPreferences.setBool('not-first-time', true);
  }
}
