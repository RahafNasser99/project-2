import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/member_profile_model.dart';
import 'package:law_platform_flutter/utils/global_classes/data.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.profile,
    required super.commentId,
    required super.text,
    required super.commentDate,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final String commentData = (json['created_at'] as String)
        .substring(0, (json['created_at'] as String).indexOf('T'));
    return CommentModel(
      profile: json['user'] != null
          ? json['user']['account-type'] == 'member'
              ? MemberProfileModel.fromJson(json['user'])
              : LawyerProfileModel.fromJson(json['user'])
          : LawyerProfileModel.fromJson(json['lawyer']),
      commentId: json['id'],
      text: json['content'] ?? json['comment'],
      commentDate: Date(comingDate: commentData).handleDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "date": commentDate.toString(),
      };
}
