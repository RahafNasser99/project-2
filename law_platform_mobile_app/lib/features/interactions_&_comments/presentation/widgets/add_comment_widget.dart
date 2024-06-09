import 'package:flutter/material.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: width * 0.9,
          child: Form(
            key: _formKey,
            child: TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                hintText: 'أضف تعليقك',
                hintTextDirection: TextDirection.rtl,
                hintStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * 0.1,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.reply_rounded),
          ),
        )
      ],
    );
  }
}
