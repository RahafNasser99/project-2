import 'package:flutter/material.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String _enteredComment = '';
  int _lineCount = 1;

  @override
  void initState() {
    _textEditingController.addListener(_updateLineCount);
    super.initState();
  }

  void _updateLineCount() {
    final textSpan = TextSpan(
      text: _textEditingController.text,
      style: Theme.of(context).textTheme.bodyLarge,
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.rtl,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: (MediaQuery.of(context).size.width - 16.0) * 0.85,
    );

    final lineCount = textPainter.computeLineMetrics().length;

    setState(() {
      _lineCount = lineCount;
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: width * 0.85,
          child: Form(
            key: _formKey,
            child: TextField(
              maxLines: _lineCount > 4 ? 4 : null,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              textInputAction: TextInputAction.newline,
              controller: _textEditingController,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorHeight: Theme.of(context).textTheme.bodyLarge!.fontSize,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'أضف تعليقك',
                hintTextDirection: TextDirection.rtl,
                hintStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onChanged: (value) {
                _enteredComment = value;
              },
            ),
          ),
        ),
        SizedBox(
          width: width * 0.1,
          child: IconButton(
            onPressed: _enteredComment.trim().isEmpty ? null : _submit,
            icon: const Icon(Icons.reply_rounded),
          ),
        )
      ],
    );
  }
}
