import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/pages/posts_home_page.dart';
import 'package:law_platform_mobile_app/features/search/presentation/pages/search_page.dart';
import 'package:law_platform_mobile_app/features/search/presentation/widgets/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _searchBarTapped = false;
  static const List<Widget> _pages = <Widget>[
    PostsHomePage(),
    Text(
      'Index 1: advice',
    ),
    Text(
      'Index 2: add',
    ),
    Text(
      'Index 3: notifications',
    ),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.of(context).pushNamed('add-post-page');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    Widget navigationDestination(String label, IconData icon) {
      return NavigationDestination(
        icon: Icon(
          icon,
          color: Colors.grey.shade400,
        ),
        selectedIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        label: label,
      );
    }

    return Scaffold(
      bottomNavigationBar: !_searchBarTapped ? Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              blurRadius: 2,
              spreadRadius: 1.5,
            )
          ],
        ),
        child: NavigationBar(
          destinations: [
            navigationDestination('منشورات', Icons.auto_stories_rounded),
            navigationDestination('استشارات', Icons.balance_rounded),
            navigationDestination('إضافة', Icons.add_box_rounded),
            navigationDestination('إشعارات', Icons.notifications_rounded),
            navigationDestination('إشعارات', Icons.notifications_rounded),
          ],
          height: height * 0.09,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          surfaceTintColor: Theme.of(context).colorScheme.inversePrimary,
          indicatorShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ) : null,
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            SearchBarWidget(searchBarTapped: _searchBarTapped,),
            Expanded(
              child: _searchBarTapped ? const SearchPage() : _pages.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
