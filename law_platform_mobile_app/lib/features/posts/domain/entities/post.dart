import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int postId;
  final String postBody;
  final String? postImage;
  final DateTime postDate;

  const Post({
    required this.postId,
    required this.postBody,
    this.postImage,
    required this.postDate,
  });

  @override
  List<Object?> get props => [postId, postBody, postImage, postDate];
}
