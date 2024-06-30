import 'package:law_platform_mobile_app/features/interactions_&_comments/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({required super.text, required super.commentDate});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        text: json['text'],
        commentDate: json['commentDate'],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "date": commentDate.toString(),
      };
}
