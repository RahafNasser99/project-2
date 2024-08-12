import 'package:flutter/material.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/comment_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/widgets/add_comment_widget.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
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
                child: Icon(
                  Icons.thumb_up_alt,
                  color: Colors.green[300],
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              GestureDetector(
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
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (context, index) => const CommentWidget(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16.0,
              ),
            ),
          ),
          if (checkAuthentication.getAccountType() != 'member')
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
              child: const AddCommentWidget(),
            ),
        ],
      ),
    );
  }
}
