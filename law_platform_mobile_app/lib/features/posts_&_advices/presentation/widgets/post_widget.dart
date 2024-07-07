import 'package:flutter/material.dart';
import 'package:law_platform_mobile_app/features/interactions_&_comments/presentation/widgets/interaction_widget.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/domain/entities/post.dart';

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
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 6.0),
              // arabic text => alignment to right , english => to left
              child: Text(
                post.postBody,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Image.network(
              fit: BoxFit.cover,
              'https://static.wixstatic.com/media/1cd646_ae7f0376474742e4ac9a0dee2f3f5a5d~mv2_d_2508_1672_s_2.jpg/v1/fill/w_925,h_616,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/1cd646_ae7f0376474742e4ac9a0dee2f3f5a5d~mv2_d_2508_1672_s_2.jpg',
            ),
          ),
          const InteractionWidget(),
        ],
      ),
    );
  }
}
