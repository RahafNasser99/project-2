import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/widgets/post_widget.dart';

class PostsHomePage extends StatefulWidget {
  const PostsHomePage({super.key});

  @override
  State<PostsHomePage> createState() => _PostsHomePageState();
}

class _PostsHomePageState extends State<PostsHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const PostWidget();
      },
    );
  }
}
