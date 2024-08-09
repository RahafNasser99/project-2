import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:law_platform_flutter/utils/global_widgets/loading.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_flutter/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/widgets/post_widget.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/cubits/get_post_cubit/get_post_cubit.dart';

class PostsHomePage extends StatefulWidget {
  const PostsHomePage({super.key, required this.postPage});

  final bool postPage; // true for posts, false for advice

  @override
  State<PostsHomePage> createState() => _PostsHomePageState();
}

class _PostsHomePageState extends State<PostsHomePage> {
  bool _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      await BlocProvider.of<GetPostCubit>(context).getPosts(widget.postPage);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPostCubit, GetPostState>(
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
          return const Center(
            child: Text('لا يوجد مناشير لعرضها'),
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
                return PostWidget(
                  post: posts[index],
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
