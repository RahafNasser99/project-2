import 'package:flutter/material.dart';
import 'package:law_platform_flutter/features/messaging/data/models/message_model.dart';
import 'package:law_platform_flutter/features/messaging/presentation/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userName, this.imageUrl});

  final String userName;
  final String? imageUrl;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: widget.imageUrl != null
                  ? NetworkImage(widget.imageUrl!)
                  : null,
              child: widget.imageUrl == null
                  ? Icon(
                      Icons.person_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView.builder(
        reverse: true,
        itemCount: 25,
        itemBuilder: (context, index) => MessageBubble(
            message: MessageModel(
              id: 1,
              messageText: 'messageText',
              messageDate: DateTime.now(),
            ),
            isMe: index.isEven ? true : false),
      ),
    );
  }
}
