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

  Future changePassword(token, {oldPassword, newPassword});
  Future<UserProfileDTO> fetchMyProfile(token);
}
