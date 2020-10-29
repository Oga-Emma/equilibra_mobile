import 'dart:io';

import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/user_dto.dart';

abstract class UserService {
  Future createAccount(
      {birthMonth,
      birthYear,
      currentCountry,
      email,
      fullName,
      password,
      username});

  Future<AuthResponseDTO> login({email, password});
  Future completeSignup(token, data);
  Future updateProfile(token, data, {File avatar});
  Future changeStateOfResidence(token, data);

  Future changePassword(token, {oldPassword, newPassword});
  Future forgotPassword(email);
  Future<AuthResponseDTO> socialAuth(accessToken, isGoogle);
  Future<UserProfileDTO> fetchMyProfile(token);
  sendFeedback(token, {String message, firstName, lastName, email});
}
