import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/utils/global_classes/data.dart';

class CommentModel extends Comment {
  CommentModel({required super.text, required super.commentDate});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final String commentData = (json['created_at'] as String)
        .substring(0, (json['created_at'] as String).indexOf('T'));
    return CommentModel(
      text: json['content'],
      commentDate: Date(comingDate: commentData).handleDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "date": commentDate.toString(),
      };
}
