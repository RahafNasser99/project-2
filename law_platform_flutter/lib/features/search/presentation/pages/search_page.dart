import 'package:flutter/material.dart';
import 'package:law_platform_flutter/features/search/presentation/widgets/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: (height - statusBarHeight - 12) * 0.06,
            margin: EdgeInsets.only(
              top: statusBarHeight + 6.0,
              bottom: 6.0,
              right: 8.0,
              left: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: (width - 12) * 0.08,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
                SizedBox(
                  width: (width - 12) * 0.92,
                  child: const SearchBarWidget(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
