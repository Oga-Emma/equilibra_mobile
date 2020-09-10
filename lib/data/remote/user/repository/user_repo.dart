import 'dart:io';

import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';

abstract class UserRepo {
  Future createAccount(
      {birthMonth,
      birthYear,
      currentCountry,
      email,
      fullName,
      password,
      username});

  Future login({email, password});
  Future completeSignup(data);
  Future updateProfile(updateProfile, {File avatar});
  Future changeStateOfResidence(data);

  Future changePassword({oldPassword, newPassword});
  Future forgotPassword(email);
  Future<UserDTO> socialAuth(accessToken, isGoogle);
  Future<UserDTO> fetchMyProfile();

  void logout();

  Future<String> getFcmToken();
  Future saveFCMToken(String token);
}
