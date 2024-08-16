import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key, required this.search});

  final Future<void> Function(String) search;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        contentPadding:
            EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
        hintText: "البحث",
        hintTextDirection: TextDirection.rtl,
      ),
      textDirection: TextDirection.rtl,
      style: Theme.of(context).textTheme.bodyLarge,
      cursorHeight: 24,
      cursorColor: Colors.grey[600],
      cursorWidth: 1.3,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) async {
        await widget.search(_controller.text);
      },
    );
  }
}
