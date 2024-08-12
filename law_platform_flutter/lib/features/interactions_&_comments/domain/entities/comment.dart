import 'package:flutter_date_difference/flutter_date_difference.dart';

abstract class Comment {
  final String text;
  final DateTime commentDate;

  Comment({
    required this.text,
    required this.commentDate,
  });

  String getCommentDuration() {
    final now = DateTime.now();
    var dateDifference = FlutterDateDifference();
    dateDifference.setLanguage(language: "ar");
    final difference = dateDifference.calculate(commentDate, now);
    List<String> splitDifference = difference.trim().split(' ');
    return splitDifference[0] + splitDifference[1];
  }
}
