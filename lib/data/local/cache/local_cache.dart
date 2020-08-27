import 'package:equilibra_mobile/model/dto/user_dto.dart';

abstract class LocalCache {
  Future<String> getToken();
  Future<void> saveToken(String token);

  Future<UserDTO> getUser();
  Future<void> saveUser(UserDTO user);

  Future<void> clear();
  Future setNotFirstTime();
  Future<String> getFcmToken();
  Future saveFcmToken(String token);
}
