class AdminNotificationDTO {
  List mutedUsers;
  List rooms;
  var id; //": "5f3813b057c4e611f7925e39",
  var message; //": "contrary to public opinion, am a fast learner",
  var createdAt; //": "2020-08-15T16:56:16.209Z",
  var updatedAt; //": "2020-08-16T18:18:18.507Z",
  var __v; //": 1

  AdminNotificationDTO.fromMap(Map<String, dynamic> data) {
    mutedUsers = data["mutedUsers"] ?? [];
    rooms = data["rooms"] ?? [];
    id = data["_id"];
    message = data["message"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    __v = data["__v"];
  }
}
