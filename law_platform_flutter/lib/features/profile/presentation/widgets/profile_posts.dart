import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:law_platform_flutter/utils/global_widgets/loading.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/widgets/post_widget.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/cubits/get_post_cubit/get_post_cubit.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/cubits/add_update_delete_post_cubit/add_update_delete_post_cubit.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({super.key, required this.userId});

  final int userId;

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  bool _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      BlocProvider.of<GetPostCubit>(context).getPosts(
        checkAuthentication.getAccountType() == 'member' ? false : true,
        widget.userId,
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _deletePost(int postId, bool postOrAdvice) async {
    BlocProvider.of<AddUpdateDeletePostCubit>(context)
        .deletePost(postId, postOrAdvice);
  }

  Future<void> _refreshPage() async {
    await BlocProvider.of<GetPostCubit>(context).getPosts(
      checkAuthentication.getAccountType() == 'member' ? false : true,
      widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: BlocConsumer<GetPostCubit, GetPostState>(
        listener: (context, state) {
          if (state is GetPostError) {
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
          if (state is GetPostLoading) {
            return Center(
              child: Loading(
                evenColor: Theme.of(context).colorScheme.primary,
                oddColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else if (state is GetPostIsEmpty) {
            return Center(
              child: Text(
                'لا يوجد مناشير لعرضها',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            );
          } else if (state is GetPostDone) {
            List<Post> posts = state.posts;
            return ListView.builder(
              controller: context.read<GetPostCubit>().scrollController,
              padding: EdgeInsets.zero,
              itemCount: context.read<GetPostCubit>().isLoadingMore
                  ? posts.length + 1
                  : posts.length,
              itemBuilder: (context, index) {
                if (index >= posts.length) {
                  return SpinKitThreeInOut(
                      itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index.isEven ? Colors.blue : Colors.grey,
                      ),
                    );
                  });
                } else {
                  return BlocProvider<AddUpdateDeletePostCubit>(
                    create: (context) => AddUpdateDeletePostCubit(),
                    child: PostWidget(
                      post: posts[index],
                      postPage: checkAuthentication.getAccountType() == 'member'
                          ? false
                          : true,
                      deletePost: _deletePost,
                      refreshPosts: _refreshPage,
                    ),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
