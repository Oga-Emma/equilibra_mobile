class AdvertDTO {
  List visibility;
  var rooms;
  var id; //": "5f2f08be884ad771dca9272b",
  var start; //": "2020-08-11T23:00:00.000Z",
  var active; //": true,
  var close; //": "2020-08-14T23:00:00.000Z",
  var image; //": "https://res.cloudinary.com/theequilibra/image/upload/v1596917950/adverts/mhpic6shcbv3tt1k7swh.jpg",
  var text; //": "The Equilibra",
  var createdAt; //": "2020-08-08T20:19:10.644Z",
  var updatedAt; //": "2020-08-15T12:57:17.340Z",
  var __v; //": 0

  AdvertDTO.fromMap(Map<String, dynamic> data) {
    visibility = data["visibility"] ?? [];
    rooms = data["rooms"] ?? [];
    id = data["_id"];
    start = data["start"];
    active = data["active"];
    close = data["close"];
    image = data["image"];
    text = data["text"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
  }
}
