import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Text(
      'Index 0: posts',
    ),
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
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
          height: height * 0.08,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          surfaceTintColor: Theme.of(context).colorScheme.inversePrimary,
          indicatorShape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      ),
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
