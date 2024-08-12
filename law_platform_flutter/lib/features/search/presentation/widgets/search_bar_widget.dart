import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _onSearchSubmitted(String query) {
    print('Search query: $query');
  }

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
      onSubmitted: _onSearchSubmitted,
    );
  }
}
