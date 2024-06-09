import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/add_comment_widget.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/comment_widget.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    
    AppBar appBar = AppBar(
      title: Text(
        'التعليقات',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: (height - appBar.preferredSize.height - 24) * 0.9,
            child: ListView.separated(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (context, index) => const CommentWidget(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            height: (height - appBar.preferredSize.height - 24) * 0.1,
            child: const AddCommentWidget(),
          ),
        ],
      ),
    );
  }
}
