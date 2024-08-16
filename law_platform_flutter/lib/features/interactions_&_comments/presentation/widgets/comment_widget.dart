import 'package:flutter/material.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/utils/global_widgets/alert_dialog_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.editComment,
    required this.deleteComment,
    required this.refreshComment,
    required this.postOrAdvice,
  });

  final Comment comment;
  final bool postOrAdvice;
  final Function editComment;
  final Future<void> Function(int) deleteComment;
  final Future<void> Function() refreshComment;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: (width - 32.0) * 0.85,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        'profile-page',
                        arguments: {
                          'userId': comment.profile?.id,
                          'accountType': comment.profile?.accountType,
                        },
                      );
                    },
                    child: Text(
                      comment.profile?.name ?? 'مستخدم',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  GestureDetector(
                    onLongPress: comment.profile?.id ==
                            checkAuthentication.getId()
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
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
                                        editComment(comment);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          elevation: 0.0,
                                          fixedSize:
                                              Size.fromWidth(width - 32.0)),
                                      label: const Text('تعديل'),
                                      icon: const Icon(Icons.edit_rounded),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialogWidget(
                                            alertTitle: 'حذف التعليق',
                                            alertContent: 'تأكيد الحذف',
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await deleteComment(
                                                  comment.commentId);
                                              await refreshComment();
                                            },
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          elevation: 0.0,
                                          fixedSize:
                                              Size.fromWidth(width - 32.0)),
                                      label: const Text('حذف'),
                                      icon: const Icon(
                                          Icons.delete_forever_rounded),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      comment.text,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('profile-page', arguments: {
                'userId': comment.profile?.id,
                'accountType': comment.profile?.accountType,
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 16.0),
              width: (width - 32.0) * 0.15,
              child: CircleAvatar(
                backgroundImage: comment.profile?.profilePicture != null
                    ? NetworkImage((comment.profile?.profilePicture)!)
                    : null,
                child: comment.profile?.profilePicture == null
                    ? Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
