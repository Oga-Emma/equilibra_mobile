import 'package:equilibra_mobile/data/remote/data/repository/data_repo.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service.dart';
import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RoomViewModel extends BaseViewModel {
  var _navigationService = getIt<NavigationService>();
  var _dataRepo = getIt<DataRepo>();

  gotoRoomScreen(RoomGroupDTO group, RoomDTO room,
      {bool isVentTheSteam = false}) {
    _navigationService.navigateTo(Routes.roomScreen,
        arguments: RoomScreenArguments(
            group: group, room: room, isVentTheSteam: isVentTheSteam));
  }

  Future<RoomDTO> fetchRoom(id) {
    return _dataRepo.fetchRoom(id);
  }

  void showVentTheSteam(RoomDTO room) {
    _navigationService.back(result: room);
  }
}
