import 'package:flutter_date_difference/flutter_date_difference.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';

abstract class Comment {
  final Profile? profile;
  final int commentId;
  final String text;
  final DateTime commentDate;

  Comment({
    required this.profile,
    required this.commentId,
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
