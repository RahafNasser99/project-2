import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/data/models/comment_model.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/add_update_delete_comment_cubit/add_edit_delete_comment_cubit.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({
    super.key,
    required this.comment,
    required this.postOrAdvice,
    required this.postId,
  });

  final String? comment;
  final bool postOrAdvice;
  final int postId;

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
    _textEditingController.text = widget.comment ?? '';
    _textEditingController.addListener(_updateLineCount);
    print('add comment widget');
    print(widget.comment);
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
      CommentModel commentModel = CommentModel(
        text: _enteredComment,
        commentDate: DateTime.now(),
      );
      await BlocProvider.of<AddEditDeleteCommentCubit>(context)
          .addOrEditComment(
        widget.comment != null ? 'edit' : 'add',
        commentModel,
        widget.postOrAdvice,
        widget.postId,
      );
    }
  }

  @override
  void didUpdateWidget(AddCommentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.comment != oldWidget.comment) {
      _textEditingController.text = widget.comment ?? '';
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
    return BlocConsumer<AddEditDeleteCommentCubit, AddEditDeleteCommentState>(
      listener: (context, state) {
        if (state is AddEditDeleteCommentDone) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _textEditingController.clear();
              _enteredComment = '';
              _lineCount = 1;
            });
          });
          // setState(() {
          //   _enteredComment = '';
          //   _lineCount = 1;
          // });
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width * 0.85,
              child: Form(
                key: _formKey,
                child: TextFormField(
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
      },
    );
  }
}
