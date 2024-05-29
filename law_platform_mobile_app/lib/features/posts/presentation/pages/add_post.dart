import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  double _keyboardHeight = 0;
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  @override
  void initState() {
    super.initState();
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      setState(() {
        _keyboardHeight = height;
        print(_keyboardHeight);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    // final isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      CircleAvatar(
                        maxRadius: height * 0.035,
                        child: Icon(
                          Icons.person_rounded,
                          size: height * 0.06,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Rahaf Nasser',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        elevation: 0.0,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'نشر',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) => SizedBox(
                height: isKeyboardVisible
                    ? (height -
                        MediaQuery.of(context).viewInsets.bottom -
                        (height * 0.6) -
                        statusBarHeight)
                    : (height - (height * 0.1) - statusBarHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: TextField(
                        scrollController: _scrollController,
                        textAlign: TextAlign.right,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'عن ماذا تريد أن تتحدث، انشر المعرفة!',
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
