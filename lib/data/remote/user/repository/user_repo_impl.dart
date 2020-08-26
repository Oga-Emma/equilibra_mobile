import 'dart:io';

import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/remote/user/service/user_service.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';

import 'user_repo.dart';
export 'user_repo.dart';

class UserRepoImpl implements UserRepo {
  LocalCache localCache;
  UserService userService;
  UserRepoImpl({this.localCache, this.userService});

  @override
  Future createAccount(
      {birthMonth,
      birthYear,
      currentCountry,
      email,
      fullName,
      password,
      username}) {
    return userService.createAccount(
        birthMonth: birthMonth,
        birthYear: birthYear,
        email: email,
        currentCountry: currentCountry,
        fullName: fullName,
        password: password,
        username: username);
  }

  @override
  Future login({email, password}) async {
    AuthResponseDTO authResponse =
        await userService.login(email: email, password: password);

    localCache.saveUser(authResponse.user);
    localCache.saveToken(authResponse.token);

    return authResponse.user;
  }

  @override
  Future completeSignup(data) async {
    return userService.completeSignup(await localCache.getToken(), data);
  }

  @override
  Future updateProfile(data, {File avatar}) async {
    return userService.updateProfile(await localCache.getToken(), data,
        avatar: avatar);
  }

  @override
  Future<UserProfileDTO> fetchMyProfile() async {
    var user = await userService.fetchMyProfile(await localCache.getToken());

    return user;
  }

  @override
  Future changePassword({oldPassword, newPassword}) async {
    return userService.changePassword(await localCache.getToken(),
        newPassword: newPassword, oldPassword: oldPassword);
  }
}
