import 'package:law_platform_flutter/utils/global_classes/data.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/member_profile_model.dart';

class PostModel extends Post {
  const PostModel({
    required super.postId,
    required super.postBody,
    super.postImage,
    required super.postDate,
    required super.commentsCount,
    required super.likesCount,
    required super.dislikesCount,
    required super.userInteraction,
    required super.profile,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    bool? userInteraction;

    String like = json['user_interaction'] != null
        ? (json['user_interaction']['liked']).toString()
        : '0';
    String dislike = json['user_interaction'] != null
        ? (json['user_interaction']['disliked']).toString()
        : '0';

    userInteraction = like == '1'
        ? true
        : dislike == '1'
            ? false
            : null;

    return PostModel(
      postId: json['id'],
      postBody: json['text'],
      postImage:
          json['image'] != null ? '$BASE_URL/storage/${json['image']}' : null,
      postDate: Date(comingDate: json['date']).handleDate(),
      commentsCount: json['comments_count'] ?? 0,
      likesCount: json['likes_count'] ?? 0,
      dislikesCount: json['dislikes_count'] ?? 0,
      userInteraction: userInteraction,
      profile: json['lawyer'] == null
          ? MemberProfileModel.fromJson(json['member'])
          : LawyerProfileModel.fromJson(json['lawyer']),
    );
  }

  Map<String, dynamic> toJson() => {
        'text': postBody,
        'image': postImage,
      };
}
