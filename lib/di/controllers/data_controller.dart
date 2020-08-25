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

  Map<String, List<RoomDTO>> _stateOfOriginRooms = {};
  List<String> _stateOfOriginRoomsFetching = [];
  var _stateOfOriginRoomsController =
      BehaviorSubject<Map<String, List<RoomDTO>>>();

  Stream<Map<String, List<RoomDTO>>> fetchStateOfOriginRooms(
      String stateId, String roomType) {
    if (!_stateOfOriginRooms.containsKey(roomType) &&
        !_stateOfOriginRoomsFetching.contains(roomType)) {
      _stateOfOriginRoomsFetching.add(roomType);

      dataRepo
          .fetchStateRooms(stateId: stateId, type: roomType, isOrigin: true)
          .then((value) {
        _stateOfOriginRooms[roomType] = value;
        _stateOfOriginRoomsController.sink.add(_stateOfOriginRooms);
        _stateOfOriginRoomsFetching.remove(roomType);
      }).catchError((err) {
        _stateOfOriginRoomsFetching.remove(roomType);
      });
    }

    return _stateOfOriginRoomsController.stream;
  }

  Map<String, List<RoomDTO>> _stateOfResidenceRooms = {};
  List<String> _stateOfResidenceRoomsFetching = [];
  var _stateOfResidenceRoomsController =
      BehaviorSubject<Map<String, List<RoomDTO>>>();

  Stream<Map<String, List<RoomDTO>>> fetchStateOfResidenceRooms(
      String stateId, String roomType) {
    if (!_stateOfResidenceRooms.containsKey(roomType) &&
        !_stateOfResidenceRoomsFetching.contains(roomType)) {
      _stateOfResidenceRoomsFetching.add(roomType);

      dataRepo
          .fetchStateRooms(stateId: stateId, type: roomType, isOrigin: false)
          .then((value) {
        _stateOfResidenceRooms[roomType] = value;
        _stateOfResidenceRoomsController.sink.add(_stateOfResidenceRooms);
        _stateOfResidenceRoomsFetching.remove(roomType);
      }).catchError((err) {
        _stateOfResidenceRoomsFetching.remove(roomType);
      });
    }

    return _stateOfResidenceRoomsController.stream;
  }

  Map<String, List<RoomDTO>> _federalRooms = {};
  List<String> _federalRoomsFetching = [];
  var _federalRoomsController = BehaviorSubject<Map<String, List<RoomDTO>>>();

  Stream<Map<String, List<RoomDTO>>> fetchFederalRooms(String roomType) {
    if (!_federalRooms.containsKey(roomType) &&
        !_federalRoomsFetching.contains(roomType)) {
      _federalRoomsFetching.add(roomType);

      dataRepo.fetchFederalRooms(type: roomType).then((value) {
        _federalRooms[roomType] = value;
        _federalRoomsController.sink.add(_federalRooms);
        _federalRoomsFetching.remove(roomType);
      }).catchError((err) {
        _federalRoomsFetching.remove(roomType);
      });
    }

    return _federalRoomsController.stream;
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
    _stateOfOriginRoomsController.close();
    _stateOfOriginRooms = {};
    _stateOfResidenceRoomsController.close();
    _stateOfResidenceRooms = {};
    _federalRoomsController.close();
    _federalRooms = {};

    super.dispose();
  }
}
