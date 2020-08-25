import 'package:intl/intl.dart';

class DateUtils {
  static var dateFormat = DateFormat("MMMM dd, yyyy");
  static var timeStampFormat = DateFormat("yyyyMMdd");
  static String getDate(date) {
    var now = DateTime.now();
    try {
      var d = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      if (d.day == now.day && d.month == now.month && d.year == now.year) {
        return "Today";
      } else if (d.day + 1 == now.day &&
          d.month == now.month &&
          d.year == now.year) {
        return "Yesterday";
      }
      return dateFormat.format(d);
    } catch (e) {
      print("Error => ${e}");
      return "";
    }
//    return "${date}";
  }

  static int getTimeStamp(date) {
    try {
      var d = DateTime.tryParse(date);
      return int.parse(timeStampFormat.format(d));
    } catch (e) {
//      print("Error => ${e}");
      return int.parse(timeStampFormat.format(DateTime.now()));
    }
//    return "${date}";
  }

  static String getTime(date) {
    return "$date";
  }

  static getTopicDates(String dateString) {
    DateTime date;
    try {
      date = DateTime.fromMillisecondsSinceEpoch(int.parse(dateString));
    } catch (e) {
//      print("Error => ${e}");
      return int.parse(timeStampFormat.format(DateTime.now()));
    }

    return "${date.day} Days(s)  ${date.day} Hours  ${date.minute} Minutes";
  }

  static getTimeToTopicChange(Duration duration) {
    return "${duration.inDays} Days  ${duration.inHours % 24} Hrs  ${duration.inMinutes % 60} Mins  ${duration.inSeconds % 60} Secs";
  }
}
