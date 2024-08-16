import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/app_drawer.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/pages/posts_home_page.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/cubits/get_post_cubit/get_post_cubit.dart';
import 'package:law_platform_flutter/features/posts_&_advices/presentation/cubits/add_update_delete_post_cubit/add_update_delete_post_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
    final width = MediaQuery.of(context).size.width;
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

    Widget buildPage(int index) {
      switch (index) {
        case 0:
          return MultiBlocProvider(
            providers: [
              BlocProvider<GetPostCubit>(
                key: UniqueKey(),
                create: (context) => GetPostCubit(),
              ),
              BlocProvider<AddUpdateDeletePostCubit>(
                create: (context) => AddUpdateDeletePostCubit(),
              ),
            ],
            child: PostsHomePage(key: UniqueKey(), postPage: true),
          );
        case 1:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                key: UniqueKey(),
                create: (context) => GetPostCubit(),
              ),
              BlocProvider<AddUpdateDeletePostCubit>(
                key: UniqueKey(),
                create: (context) => AddUpdateDeletePostCubit(),
              ),
            ],
            child: PostsHomePage(key: UniqueKey(), postPage: false),
          );
        case 3:
          return const Text('Index 3: notifications');
        default:
          return const Text('Index 2: add');
      }
    }

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
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(2.0),
              height: height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: width * 0.1,
                    child: Builder(builder: (context) {
                      return GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[600],
                          maxRadius: height * 0.03,
                        ),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    }),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                          ),
                          Text(
                            'البحث',
                            textDirection: TextDirection.rtl,
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
            ),
            Expanded(
              child: buildPage(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
