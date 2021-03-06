import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class DataRepo {
  Future<List<GovernmentDTO>> fetchGovernment();
  Future<List<RoomDTO>> fetchHomeHouseOfAssemblyRooms(String stateId);
  Future<List<RoomDTO>> fetchHomeHouseOfRepRooms(String stateId);
  Future<List<RoomDTO>> fetchHomeLGSRooms(String stateId);
  Future<List<RoomDTO>> fetchHomeSenateRooms(String stateId);

  Future<List<RoomDTO>> fetchStateRooms(
      {String stateId, String type, bool isOrigin});
  Future<List<RoomDTO>> fetchFederalRooms({String type});
  Future<RoomDTO> fetchRoom(String id);
}
