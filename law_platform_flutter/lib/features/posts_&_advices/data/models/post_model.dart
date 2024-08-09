import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';
import 'package:law_platform_flutter/features/profile/data/models/member_profile_model.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/global_classes/data.dart';

class PostModel extends Post {
  const PostModel({
    required super.postId,
    required super.postBody,
    super.postImage,
    required super.postDate,
    required super.commentsCount,
    required super.likesCount,
    required super.dislikesCount,
    required super.profile,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json['id'],
        postBody: json['text'],
        postImage:
            json['image'] != null ? '$BASE_URL/storage/${json['image']}' : null,
        postDate: Date(comingDate: json['date']).handleDate(),
        commentsCount: json['comments_count'],
        likesCount: json['likes_count'],
        dislikesCount: json['dislikes_count'],
        profile: checkAuthentication.getAccountType() == 'member'
            ? MemberProfileModel.fromJson(json['member'])
            : LawyerProfileModel.fromJson(
                json['lawyer'],
              ),
      );

  Map<String, dynamic> toJson() => {
        'text': postBody,
        'image': postImage,
      };
}
