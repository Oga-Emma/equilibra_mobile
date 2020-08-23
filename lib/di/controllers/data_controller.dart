import 'package:equilibra_mobile/data/remote/data/repository/data_repo.dart';
import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/model/dto/government_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:stacked/stacked.dart';

export 'package:provider/provider.dart';

class DataController extends BaseViewModel {
  var dataRepo = GetIt.instance<DataRepo>();

  bool _governmentsIsFetching = false;
  var _governmentsController = BehaviorSubject<List<GovernmentDTO>>();

  Stream<List<GovernmentDTO>> fetchGovernments() {
    if (!_governmentsIsFetching) {
      dataRepo.fetchGovernment().then((value) {
        _governmentsController.add(value);
      }).catchError((err) {
        print(err);
      });
    }
    return _governmentsController.stream;
  }

  Future<List<RoomDTO>> fetchLGA(String stateId) {
    return dataRepo.fetchHomeLGSRooms(stateId);
  }

  Future<List<RoomDTO>> fetchHouseOfAssembly(String stateId) {
    return dataRepo.fetchHomeHouseOfAssemblyRooms(stateId);
  }

  Future<List<RoomDTO>> fetchHouseOfRep(String stateId) {
    return dataRepo.fetchHomeHouseOfRepRooms(stateId);
  }

  Future<List<RoomDTO>> fetchSenateRooms(String stateId) {
    return dataRepo.fetchHomeSenateRooms(stateId);
  }

  @override
  void dispose() {
    _governmentsController.close();
    super.dispose();
  }
}
