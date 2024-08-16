import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/utils/global_classes/data.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/global_widgets/alert_dialog_widget.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/interaction_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/interaction_cubit/interaction_cubit.dart';

// ignore: must_be_immutable
class PostWidget extends StatelessWidget {
  PostWidget({
    super.key,
    required this.post,
    required this.postPage,
    required this.deletePost,
    required this.refreshPosts,
  });

  final Post post;
  final bool postPage;
  Future<void> Function(int, bool) deletePost;
  Future<void> Function() refreshPosts;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            spreadRadius: 2.0,
            blurRadius: 2.0,
            color: Colors.grey[300]!,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              trailing: checkAuthentication.getId() == post.profile.id
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                )),
                            width: double.infinity,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              direction: Axis.vertical,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context)
                                        .pushNamed('add-post-page', arguments: {
                                      'postId': post.postId,
                                      'postBody': post.postBody,
                                      'postImage': post.postImage,
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      elevation: 0.0,
                                      fixedSize: Size.fromWidth(width - 32.0)),
                                  label: const Text('تعديل'),
                                  icon: const Icon(Icons.edit_rounded),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialogWidget(
                                        alertTitle: checkAuthentication
                                                    .getAccountType() ==
                                                'member'
                                            ? 'حذف الاستشارة'
                                            : 'حذف المنشور',
                                        alertContent: 'تأكيد الحذف',
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await deletePost(
                                                  post.postId,
                                                  checkAuthentication
                                                              .getAccountType() ==
                                                          'member'
                                                      ? false
                                                      : true)
                                              .then(
                                            (_) async {
                                              Navigator.pop(context);
                                              await refreshPosts();
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      elevation: 0.0,
                                      fixedSize: Size.fromWidth(width - 32.0)),
                                  label: const Text('حذف'),
                                  icon:
                                      const Icon(Icons.delete_forever_rounded),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.more_vert_rounded),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              leading: CircleAvatar(
                backgroundImage: post.profile.profilePicture != null
                    ? NetworkImage(post.profile.profilePicture!)
                    : null,
                child: post.profile.profilePicture == null
                    ? Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              title: Text(
                post.profile.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(Date(comingDate: '').getStringDate(post.postDate),
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          if (post.postBody != null)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 6.0),
                // arabic text => alignment to right , english => to left
                child: Text(
                  post.postBody!,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          if (post.postImage != null)
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 6.0),
              child: Image.network(
                fit: BoxFit.cover,
                post.postImage!,
              ),
            ),
          BlocProvider<InteractionCubit>(
            create: (context) => InteractionCubit(),
            child: InteractionWidget(
              postPage: postPage,
              postId: post.postId,
              likes: post.likesCount,
              dislikes: post.dislikesCount,
              comments: post.commentsCount,
              userInteraction: post.userInteraction,
            ),
          ),
        ],
      ),
    );
  }
}
