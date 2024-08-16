import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/get_interactions_cubit/get_interactions_cubit.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/pages/interactions_page.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/domain/entities/comment.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/models/comment_model.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/comment_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/add_comment_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/comment_cubit/get_comments_cubit.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/add_update_delete_comment_cubit/add_edit_delete_comment_cubit.dart';
import 'package:page_transition/page_transition.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  bool _isInit = true;
  bool _postOrAdvice = true;
  Profile? _profile;
  int _postId = 0;
  int _commentId = 0;
  String _commentToBeEdited = '';
  DateTime _commentDate = DateTime.now();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final settingsData =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _postOrAdvice = settingsData['postOrAdvice'];
      _postId = settingsData['postId'];
      BlocProvider.of<GetCommentsCubit>(context)
          .getAllComments(_postOrAdvice, _postId);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshComments() async {
    BlocProvider.of<GetCommentsCubit>(context)
        .getAllComments(_postOrAdvice, _postId);
  }

  void _editComment(Comment comment) {
    setState(() {
      _profile = comment.profile;
      _commentId = comment.commentId;
      _commentToBeEdited = comment.text;
      _commentDate = comment.commentDate;
    });
  }

  Future<void> _deleteComment(int commentId) async {
    BlocProvider.of<AddEditDeleteCommentCubit>(context)
        .deleteComment(commentId, _postOrAdvice);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'التعليقات',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    child: BlocProvider<GetInteractionsCubit>(
                      create: (context) => GetInteractionsCubit(),
                      child: InteractionsPage(
                        likeOrDislike: true,
                        postId: _postId,
                      ),
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ));
                },
                child: Icon(
                  Icons.thumb_up_alt,
                  color: Colors.green[300],
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    child: BlocProvider<GetInteractionsCubit>(
                      create: (context) => GetInteractionsCubit(),
                      child: InteractionsPage(
                        likeOrDislike: false,
                        postId: _postId,
                      ),
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ));
                },
                child: Icon(
                  Icons.thumb_down_alt,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<GetCommentsCubit, GetCommentsState>(
            listener: (context, state) {
              if (state is GetCommentsError) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ShowDialog(
                    dialogMessage: state.errorMessage,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetCommentsLoading) {
                return Expanded(
                  child: Center(
                    child: Icon(
                      Icons.forum_rounded,
                      size: 60,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                );
              } else if (state is GetCommentsIsEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'لا يوجد تعليقات لعرضها',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                );
              } else if (state is GetCommentsDone) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.comments.length,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) => CommentWidget(
                      comment: state.comments[index],
                      postOrAdvice: _postOrAdvice,
                      editComment: _editComment,
                      deleteComment: _deleteComment,
                      refreshComment: _refreshComments,
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          if ((checkAuthentication.getAccountType() != 'member' &&
                  !_postOrAdvice) ||
              _postOrAdvice)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2.0,
                    blurRadius: 2.0,
                    color: Theme.of(context).colorScheme.surface,
                  )
                ],
              ),
              child: BlocConsumer<AddEditDeleteCommentCubit,
                  AddEditDeleteCommentState>(
                listener: (context, state) {
                  if (state is AddEditDeleteCommentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  } else if (state is AddEditDeleteCommentDone) {
                    setState(() {
                      _commentToBeEdited = '';
                    });
                  }
                },
                builder: (context, state) {
                  return BlocProvider(
                    create: (context) => AddEditDeleteCommentCubit(),
                    child: AddCommentWidget(
                        key: ValueKey(_commentToBeEdited),
                        refreshComment: _refreshComments,
                        postOrAdvice: _postOrAdvice,
                        postId: _postId,
                        comment: CommentModel(
                          profile: _profile,
                          commentId: _commentId,
                          text: _commentToBeEdited.isEmpty
                              ? ''
                              : _commentToBeEdited,
                          commentDate: _commentDate,
                        )),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
