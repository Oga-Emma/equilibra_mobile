import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/data/remote/data/repository/data_repo.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service.dart';
import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final logger = Logger();

class RoomController extends BaseViewModel {
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

  SocketIOManager _manager;
  SocketIO _socket;
  IO.Socket socket;
  setupSocket() async {
//    final localCache = getIt<LocalCache>();
//    final token = await localCache.getToken();

    if (_manager != null) return;
//    final user = await localCache.getUser();
    _manager = SocketIOManager();
    SocketOptions options = SocketOptions(
      '${BaseApi().BASE_URL}/', /*query: {'token': 'Bearer $token'}*/
    );
    _socket = await _manager
        .createInstance(options); //TODO change the port  accordingly

    _socket.onConnect((data) {
      logger.d('connected');

//      _socket.emit("room connection", [room]);
    });
    _socket.on("update", (data) {
      try {} catch (err) {
        logger.e(err);
        showErrorToast('Internal client error');
      }
    });
    _socket.onConnectError((data) {
      logger.e('connection error => $data');
      showErrorToast('Network error');
    });
    _socket.onError((data) {
      logger.e('error => ${data}');
      showErrorToast('Network error');
    });
    try {
      _socket.connect();
    } catch (err) {
      logger.e(err);
      showErrorToast('Network error');
    }

    ///disconnect using
    ///manager.
  }

  @override
  void dispose() {
    _manager?.clearInstance(_socket);
    socket?.disconnect();
    super.dispose();
  }
}
