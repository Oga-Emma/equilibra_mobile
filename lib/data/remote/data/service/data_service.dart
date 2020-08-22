import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

abstract class DataService {
  Future<List<GovernmentDTO>> fetchGovernment();
  Future<List<RoomDTO>> fetchRoom(String type, String stateId);
}
