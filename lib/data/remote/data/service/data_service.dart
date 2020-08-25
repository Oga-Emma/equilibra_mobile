import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class DataService {
  Future<List<GovernmentDTO>> fetchGovernment();
  Future<List<RoomDTO>> fetchHomeRoom(String type, String stateId);
  Future<List<RoomDTO>> fetchStateRooms(String token,
      {String type, String stateId, bool origin = false});
  Future<List<RoomDTO>> fetchFederalRooms(String token, String type);
  Future<RoomDTO> fetchRoom(String token, String id);
}
