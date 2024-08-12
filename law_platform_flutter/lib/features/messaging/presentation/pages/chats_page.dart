import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:law_platform_flutter/features/messaging/presentation/pages/chat_page.dart';
import 'package:law_platform_flutter/features/search/presentation/widgets/list_tile_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الدردشات',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.of(context).push(PageTransition(
              child: const ChatPage(
                userName: 'userName',
                imageUrl: null,
              ),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 300),
            ));
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          leading: CircleAvatar(
            child: Icon(
              Icons.person_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            'profile.name',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // ListTileWidget(profile: profile),
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.2,
        ),
        itemCount: 20,
      ),
    );
  }
}
