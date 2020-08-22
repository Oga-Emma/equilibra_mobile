import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class DataRepo {
  Future<List<GovernmentDTO>> fetchGovernment();
  Future<List<RoomDTO>> fetchLGSRooms(String stateId);
  Future<List<RoomDTO>> fetchHouseOfAssemblyRooms(String stateId);
  Future<List<RoomDTO>> fetchHouseOfRepRooms(String stateId);
  Future<List<RoomDTO>> fetchSenateRooms(String stateId);
}
