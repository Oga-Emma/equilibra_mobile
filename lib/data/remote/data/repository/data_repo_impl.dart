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
  Future<List<RoomDTO>> fetchHouseOfAssemblyRooms(String stateId) {
    return dataService.fetchRoom('HOA', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchHouseOfRepRooms(String stateId) {
    return dataService.fetchRoom('HOR', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchLGSRooms(String stateId) {
    return dataService.fetchRoom('LGA', stateId);
  }

  @override
  Future<List<RoomDTO>> fetchSenateRooms(String stateId) {
    return dataService.fetchRoom('SENATE', stateId);
  }
}
