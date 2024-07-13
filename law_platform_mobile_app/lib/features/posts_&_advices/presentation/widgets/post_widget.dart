import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/interaction_widget.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/entities/post.dart';
import 'package:law_platform_mobile_app/utils/global_classes/data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            spreadRadius: 2.0,
            blurRadius: 2.0,
            color: Colors.grey[300]!,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              leading: CircleAvatar(
                child: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                'رهف نصر',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(Date(comingDate: '').getStringDate(post.postDate),
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          if (post.postBody != null)
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 6.0),
                // arabic text => alignment to right , english => to left
                child: Text(
                  post.postBody!,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          if (post.postImage != null)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Image.network(
                fit: BoxFit.cover,
                post.postImage!,
              ),
            ),
          const InteractionWidget(),
        ],
      ),
    );
  }
}
