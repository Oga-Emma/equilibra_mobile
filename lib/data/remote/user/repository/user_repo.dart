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

  Future<UserDTO> fetchMyProfile();
}
