import 'package:flutter/material.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key, required this.isKeyboardVisible});

  final bool isKeyboardVisible;

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String _commentText = '';

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_commentText);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: width * 0.9,
          child: Form(
            key: _formKey,
            child: TextField(
              maxLines: null,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              textInputAction: TextInputAction.newline,
              controller: _textEditingController,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorHeight: Theme.of(context).textTheme.bodyLarge!.fontSize,
              decoration: InputDecoration(
                contentPadding: widget.isKeyboardVisible
                    ? const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 2.0)
                    : const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 0.0),
                border: InputBorder.none,
                hintText: 'أضف تعليقك',
                hintTextDirection: TextDirection.rtl,
                hintStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onChanged: (value) {
                _commentText = value;
              },
            ),
          ),
        ),
        SizedBox(
          width: width * 0.1,
          child: IconButton(
            onPressed: _submit,
            icon: const Icon(Icons.reply_rounded),
          ),
        )
      ],
    );
  }
}
