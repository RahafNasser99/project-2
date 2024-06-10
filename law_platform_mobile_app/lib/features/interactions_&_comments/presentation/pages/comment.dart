import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/add_comment_widget.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/comment_widget.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  double _keyboardHeight = 0;
  double actualHeight = 0;

  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  @override
  void initState() {
    super.initState();
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      setState(() {
        _keyboardHeight = height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    AppBar appBar = AppBar(
      title: Text(
        'التعليقات',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
    return Scaffold(
      appBar: appBar,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          actualHeight = height -
              _keyboardHeight -
              appBar.preferredSize.height -
              statusBarHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height:
                    isKeyboardVisible ? actualHeight * 0.6 : actualHeight * 0.8,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                height:
                    isKeyboardVisible ? actualHeight * 0.4 : actualHeight * 0.2,
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
                child: AddCommentWidget(
                  isKeyboardVisible: isKeyboardVisible,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
