import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/add_update_delete_comment_cubit/add_edit_delete_comment_cubit.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/delete_comment_alert_dialog.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.editComment,
    required this.postOrAdvice,
  });

  final Comment comment;
  final bool postOrAdvice;
  final Function editComment;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Future<void> _deleteComment() async {
      BlocProvider.of<AddEditDeleteCommentCubit>(context)
          .deleteComment(comment.commentId, postOrAdvice);
    }

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
                  Text(
                    'رهف نصر',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  GestureDetector(
                    onLongPress: () {
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
                                  editComment(comment);
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
                                  DeleteCommentAlertDialog(
                                    alertTitle: 'حذف التعليق',
                                    onPressed: () {},
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    elevation: 0.0,
                                    fixedSize: Size.fromWidth(width - 32.0)),
                                label: const Text('حذف'),
                                icon: const Icon(Icons.delete_forever_rounded),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            width: (width - 32.0) * 0.15,
            child: CircleAvatar(
              child: Icon(
                Icons.person_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
