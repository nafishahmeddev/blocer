import 'package:intl/intl.dart';

class DateTimeFormatter{
  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inDays == 1) {
      return "yesterday";
    }
    if (diff.inHours > 0) {
      return DateFormat("hh:mm a").format(d);
    }
    if (diff.inMinutes > 0) {
      return DateFormat("hh:mm a").format(d);
    }
    return "just now";
  }
}