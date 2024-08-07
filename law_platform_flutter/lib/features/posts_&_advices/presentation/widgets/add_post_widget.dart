import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AddPostWidget extends StatefulWidget {
  const AddPostWidget({
    super.key,
    required this.postOrAdvice,
    required this.postBody,
    required this.postImage,
    required this.height,
    required this.image,
    required this.textEditingController,
    required this.editImage,
    required this.setImage,
    required this.setPostBody,
  });

  final bool postOrAdvice; //true for post, false for advice
  final String? postBody;
  final String? postImage;
  final double height;
  final File? image;
  final TextEditingController textEditingController;
  final void Function()? editImage;
  final void Function(File?) setImage;
  final void Function(String) setPostBody;

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  File? showedImage;
  String? postImage;
  String? postText;
  double _keyboardHeight = 0;
  double insideHeight = 0;
  int maxLines = 5;
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // if (widget.post != null) {
    //   _textEditingController.text = widget.post!.postBody;
    // }
    postText = widget.postBody;
    postImage = widget.postImage;
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      setState(() {
        _keyboardHeight = height;
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddPostWidget oldWidget) {
    showedImage = widget.image;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _keyboardHeightPlugin.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: KeyboardVisibilityBuilder(
        builder: (ctx, isKeyboardVisible) {
          insideHeight = widget.height - _keyboardHeight;
          maxLines = ((insideHeight / 1.6) /
                  ((Theme.of(context).textTheme.labelLarge?.fontSize)!.floor() +
                      5))
              .floor();
          if (isKeyboardVisible) {
            maxLines--;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _textEditingController,
                            // initialValue: postText,
                            textAlign: TextAlign.right,
                            maxLines: showedImage != null ? 4 : maxLines,
                            textInputAction: TextInputAction.newline,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.postOrAdvice
                                  ? 'عن ماذا تريد أن تتحدث، انشر المعرفة!'
                                  : 'ماذا تريد أن تعرف، اكتب سؤالك',
                              hintStyle: Theme.of(context).textTheme.labelLarge,
                              hintTextDirection: TextDirection.rtl,
                            ),
                            onChanged: (value) {
                              postText = value;
                              widget.setPostBody(value);
                            },
                          ),
                        ),
                      ),
                      if (showedImage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: widget.editImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
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
                                  'تعديل',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  widget.setImage(null);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
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
                                  'إزالة',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (showedImage != null) Image.file(widget.image!),
                    ],
                  ),
                ),
              ),
              if (showedImage == null)
                SizedBox(
                  height: 50,
                  child: IconButton(
                    onPressed: widget.editImage,
                    icon: Icon(
                      Icons.image_rounded,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
