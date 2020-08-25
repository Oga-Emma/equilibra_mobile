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
  var id;
  var comment;
  var reporter;
  var report;
  UserShortInfo author;
  List replies = [];
  List reports;
  int likes;
  bool liked;
  bool reply;
  bool replied;
  bool edited;
  bool reported;
  var image;
  var images = [];
  var createdAt;
  var updatedAt;

  String getDate() {
    if (updatedAt != null) {
      try {
        int dateMilli = int.parse(updatedAt);
        var date = DateTime.fromMillisecondsSinceEpoch(dateMilli);

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
    likes = data["likes"] ?? 0;
    liked = data["liked"];
    reported = data["reported"] ?? false;
    reply = data["reply"];
    replied = data["replied"];
    edited = data["edited"];
//    reported = data["reported"];
    image = data["image"];
    createdAt = data["createdAt"];
    updatedAt = data["updatedAt"];
    author = UserShortInfo.fromMap(data['author'] ?? {});

    replies.addAll(data["replies"] ?? []);
    images.addAll(data["images"] ?? []);

    if (image != null) {
      images.add(image);
    }

//    print(images);
  }
}
