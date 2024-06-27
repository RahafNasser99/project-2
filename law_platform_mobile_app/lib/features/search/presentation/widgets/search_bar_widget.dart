import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.searchBarTapped
  });

  final bool searchBarTapped;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(2.0),
      height: height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: width * 0.1,
            child: CircleAvatar(
                backgroundColor: Colors.grey[600], maxRadius: height * 0.03),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('search-page');
            },
            child: Container(
              width: width * 0.75,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message_rounded,
                color: Colors.grey[600],
              ),
            ),
          )
        ],
      ),
    );
  }
}
