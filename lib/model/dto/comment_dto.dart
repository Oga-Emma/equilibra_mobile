import 'package:intl/intl.dart';
import 'user_dto.dart';

/*

{_id: 5d73ad7a49586127641aec20,
comment: ...and bad roads?,
reporter: null,
report: null,
replies: [],
reports: [],
likes: 0,
liked: false,
reply: false,
replied: false,
edited: false,
reported: false,
image: https://res.cloudinary.com/dikky/image/upload/v1567862151/comment-images/5d73ad7a49586127641aec20.jpg,
createdAt: 1567862138542,
updatedAt: 1567862152089,
successMessage: null

 */

class CommentDTO {
  //{"
  var id; //":"5f397cd357c4e611f7925e59",
  List replies = []; //":[],
  List likes = []; //":[],
  var reply; //":false,
  var replied; //":false,
  var edited; //":false,
  List images = []; //":[],
  var reported; //":false,
  var comment; //":"Okay",
  // "topic":{"_id":"5f1c75ff4a2e612c906027ad","description":"Education in Nigeria","title":"EDUCATION"},"room":{"_id":"5e3d4a47fb9e016690a5bbc4","name":"Vent The Steam"},
  var author; //":{"_id":"5f37df7ef39e9d5ca0aaf47e","avatar":"","suspended":false,"fullName":"Mokoman2","username":"mokoman2"},
  var authorType; //":"Member","
  List reports = []; //":[],
  var createdAt; //":"2020-08-16T18:37:07.811Z",
  var updatedAt; //":"2020-08-16T18:38:08.369Z",
  var __v; //":1}

  String getDate() {
    if (updatedAt != null) {
      try {
        var date = DateTime.tryParse(updatedAt);
//        int dateMilli = int.parse(updatedAt);
//        var date = DateTime.fromMillisecondsSinceEpoch(dateMilli);

        return dateFormat.format(date);
      } catch (e) {
        print(e);
        return dateFormat.format(DateTime.now());
      }
    }
    return "";
  }

  static var dateFormat = DateFormat("hh:mm a");
//  static var dateFormat = DateFormat("hh:mm a | MMM-dd");

  CommentDTO.fromJson(Map<dynamic, dynamic> data) {
//    print("COMMENT => $data");

    id = data["_id"];
    comment = data["comment"];
//    reporter = data["reporter"];
//    report = data["report"];
//    reports = data["reports"];
    likes.addAll(data["likes"] ?? []);
//    liked = data["liked"];
    reported = data["reported"] ?? false;
    reply = data["reply"];
    replied = data["replied"];
    edited = data["edited"];
//    reported = data["reported"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    author = UserShortInfo.fromMap(data['author'] ?? {});

    replies.addAll(data["replies"] ?? []);
    images.addAll(data["images"] ?? []);
    reports.addAll(data["reports"] ?? []);

//    print(images);
  }

  liked(id) {
    return this.likes.contains(id);
  }
}
