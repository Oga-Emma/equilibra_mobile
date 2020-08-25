import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service.dart';
import 'package:equilibra_mobile/model/dto/auth_response_dto.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';

import 'data_repo.dart';
export 'data_repo.dart';

class DataRepoImpl implements DataRepo {
  LocalCache localCache;
  DataService dataService;
  DataRepoImpl({this.localCache, this.dataService});

  Future<List<GovernmentDTO>> fetchGovernment() {
    return dataService.fetchGovernment();
  }

  @override
  Future<List<RoomDTO>> fetchHomeHouseOfAssemblyRooms(String stateId) {
    return dataService.fetchHomeRoom('HOA', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchHomeHouseOfRepRooms(String stateId) {
    return dataService.fetchHomeRoom('HOR', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchHomeLGSRooms(String stateId) {
    return dataService.fetchHomeRoom('LGA', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchHomeSenateRooms(String stateId) {
    return dataService.fetchHomeRoom('SENATE', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchStateRooms(
      {String stateId, String type, bool isOrigin}) async {
    return dataService.fetchStateRooms(await localCache.getToken(),
        type: type, stateId: stateId, origin: isOrigin);
  }

  @override
  Future<List<RoomDTO>> fetchFederalRooms({String type}) async {
    return dataService.fetchFederalRooms(await localCache.getToken(), type);
  }
}
