import 'package:equatable/equatable.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';

class Post extends Equatable {
  final int postId;
  final String? postBody;
  final String? postImage;
  final DateTime postDate;
  final int commentsCount;
  final int likesCount;
  final int dislikesCount;
  final Profile profile;

  const Post({
    required this.postId,
    required this.postBody,
    this.postImage,
    required this.postDate,
    required this.commentsCount,
    required this.likesCount,
    required this.dislikesCount,
    required this.profile,
  });

  @override
  List<Object?> get props => [postId, postBody, postImage, postDate, profile];
}
