import 'package:law_platform_mobile_app/features/posts_&_advices/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel(
      {required super.postId,
      required super.postBody,
      super.postImage,
      required super.postDate});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json['postId'],
        postBody: json['postBody'],
        postImage: json['image'],
        postDate: json['postDate'],
      );

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'postBody': postBody,
        'postImage': postImage,
        'postDate': postDate
      };
}
