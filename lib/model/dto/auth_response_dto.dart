import 'package:equilibra_mobile/model/dto/user_dto.dart';

class AuthResponseDTO {
  UserDTO user;
  String token;

  AuthResponseDTO.fromMap(Map<String, dynamic> data) {
    user = UserDTO.fromMap(data['user']);
    token = data["accessToken"]["token"];
  }
}
