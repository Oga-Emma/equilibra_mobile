import 'dart:convert';
import 'dart:io';

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
  Stream<EventHandler> connectRoomEvent() {
    if (eventHandlerStream != null) {
      eventHandlerStream.close();
    }
    eventHandlerStream = BehaviorSubject<EventHandler>();
    return eventHandlerStream.stream;
  }

  Stream<EventHandler> connectHomeEvent() {
    if (eventHandlerStream != null) {
      eventHandlerStream.close();
    }
    eventHandlerStream = BehaviorSubject<EventHandler>();
    return eventHandlerStream.stream;
  }

  addEvent(EventHandler event) {
    try {
      if (eventHandlerStream != null && eventHandlerStream.hasListener) {
        eventHandlerStream.sink.add(event);
      }
    } catch (err) {
      logger.e(err);
    }
  }

  closeEventHandlerStream() {
    eventHandlerStream?.close();
    eventHandlerStream = null;
  }

  Future<List<CommentDTO>> fetchComments({page, limit, roomId, topicId}) async {
    return _roomRepo.fetchComments(
        page: page ?? 1, limit: limit ?? 100, roomId: roomId, topicId: topicId);
  }

  Future<CommentDTO> createComments(
      {List<File> images,
      String comment,
      String topicId,
      String roomId}) async {
    return await _roomRepo.createComment(
        comment: comment, images: images, topicId: topicId, roomId: roomId);
  }

  Future replyComment({images, comment, commentId}) async {
    return await _roomRepo.replyComment(
        comment: comment, images: images, commentId: commentId);
  }

  Future likeComment(commentId) async {
    return await _roomRepo.likeComment(commentId: commentId);
  }

  Future unlikeComment(commentId) async {
    return await _roomRepo.unlikeComment(commentId: commentId);
  }

  Future deleteComment(commentId) async {
    return await _roomRepo.deleteComment(commentId: commentId);
  }

  Future reportComment({report, commentId}) async {
    return await _roomRepo.reportComment(commentId: commentId, report: report);
  }

  Future joinRoom(roomId) async {
    try {
      setBusy(true);
      await _roomRepo.joinRoom(roomId);
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
  }

  Future leaveRoom(roomId) async {
    try {
      setBusy(true);
      await _roomRepo.leaveRoom(roomId);
    } catch (err) {
      setBusy(false);
      throw err;
    }
    setBusy(false);
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

    _socket.on('comment', (data) {
//      print("comment $data");
      addEvent(EventHandler(EventTypes.COMMENT, data));
    });
//    {user: 5f40eca257c4e611f7925e7f, room: 5e3d4a48fb9e016690a5bc08}
    _socket.on('join-room', (data) {
//      print("join-room $data");
      addEvent(EventHandler(EventTypes.JOIN_ROOM, data));
    });

    _socket.on('leave-room', (data) {
      addEvent(EventHandler(EventTypes.LEAVE_ROOM, data));
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

  void showVentTheSteam(RoomDTO room) {
    _navigationService.back(result: room);
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
  JOIN_ROOM,
  LEAVE_ROOM,
}
