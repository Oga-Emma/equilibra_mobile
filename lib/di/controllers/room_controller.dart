import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:equilibra_mobile/data/config/base_api.dart';
import 'package:equilibra_mobile/data/remote/data/repository/data_repo.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service.dart';
import 'package:equilibra_mobile/data/remote/room/repository/room_repo.dart';
import 'package:equilibra_mobile/di/di.dart';
import 'package:equilibra_mobile/model/dto/comment_dto.dart';
import 'package:equilibra_mobile/model/dto/room_dto.dart';
import 'package:equilibra_mobile/ui/router/router.gr.dart';
import 'package:helper_widgets/custom_toasts.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final logger = Logger();

class RoomController extends BaseViewModel {
  var _navigationService = getIt<NavigationService>();
  var _dataRepo = getIt<DataRepo>();
  var _roomRepo = getIt<RoomRepo>();

  RoomController() {
    setupSocket();
  }
  gotoRoomScreen(RoomGroupDTO group, RoomDTO room,
      {bool isVentTheSteam = false}) {
    _navigationService.navigateTo(Routes.roomScreen,
        arguments: RoomScreenArguments(
            group: group, room: room, isVentTheSteam: isVentTheSteam));
  }

  Future<RoomDTO> fetchRoom(id) async {
    return await _dataRepo.fetchRoom(id);
  }

  BehaviorSubject<EventHandler> eventHandlerStream;
  Stream<EventHandler> initEventHandlerStream() {
    eventHandlerStream = BehaviorSubject<EventHandler>();
    return eventHandlerStream.stream;
  }

  addEvent(EventHandler event) {
    if (eventHandlerStream != null && eventHandlerStream.hasListener) {
      eventHandlerStream.sink.add(event);
    }
  }

  closeEventHandlerStream() {
    eventHandlerStream.close();
    eventHandlerStream = null;
  }

  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId}) async {
    return _roomRepo.fetchComments(
        page: page ?? 1, limit: limit ?? 100, roomId: roomId, topicId: topicId);
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

    _socket.on('connect', (data) {
      print("connect $data");
    });
    _socket.on('join-room', (data) {
      print("join-room $data");
    });
    _socket.on('leave-room', (data) {
      print("leave-room $data");
    });
    _socket.on('comment', (data) {
      print("comment $data");
      addEvent(EventHandler(EventTypes.COMMENT, CommentDTO.fromJson(data)));
    });
    _socket.on('topic-changed', (data) {
      print("topic-changed $data");
    });
    _socket.on('vote-topic-change', (data) {
      print("vote-topic-change $data");
    });
    _socket.on('new-vote', (data) {
      print("new-vote $data");
    });
    _socket.on('vote-topic-closed', (data) {
      print("vote-topic-closed $data");
    });
    _socket.on('topic-discussion-vote', (data) {
      print("topic-discussion-vote $data");
    });
    _socket.on('close-discussion-vote', (data) {
      print("close-discussion-vote $data");
    });
    _socket.on('disconnect', (data) {});

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

class EventHandler {
  EventTypes type;
  var data;
  EventHandler(this.type, this.data);
}

enum EventTypes {
  COMMENT,
}
