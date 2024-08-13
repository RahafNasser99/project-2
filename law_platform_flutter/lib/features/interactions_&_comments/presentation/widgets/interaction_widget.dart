import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class InteractionWidget extends StatefulWidget {
  const InteractionWidget({
    super.key,
    required this.postPage,
    required this.postId,
    required this.likes,
    required this.dislikes,
    required this.comments,
  });

  final bool postPage;
  final int postId;
  final int likes;
  final int dislikes;
  final int comments;

  @override
  State<InteractionWidget> createState() => _InteractionWidgetState();
}

class _InteractionWidgetState extends State<InteractionWidget> {
  bool _like = false;
  bool _dislike = false;
  int _numOfLike = 0;
  int _numOfDislike = 0;
  int _numOfComments = 0;

  @override
  void didChangeDependencies() {
    _numOfLike = widget.likes;
    _numOfDislike = widget.dislikes;
    _numOfComments = widget.comments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      /// send your request here
      // final bool success= await sendRequest();

      setState(() {
        _like = !_like;
        if (_like) {
          _dislike = false;
          _numOfLike++;
          // if number of dislike greater than the base likes reduce it one like
        } else {
          _numOfLike--;
        }
      });

      return !isLiked;
    }

    Future<bool> onDislikeButtonTapped(bool isLiked) async {
      /// send your request here
      // final bool success= await sendRequest();

      setState(() {
        _dislike = !_dislike;
        if (_dislike) {
          _like = false;
          _numOfDislike++;
          // if number of like greater than the base likes reduce it one like
        } else {
          _numOfDislike--;
        }
      });

      return !isLiked;
    }

    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (widget.postPage)
            LikeButton(
              isLiked: _like,
              onTap: onLikeButtonTapped,
              likeBuilder: (isLiked) {
                return Icon(
                  isLiked ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
                  color: isLiked ? Colors.green[300] : Colors.black54,
                );
              },
              circleColor: CircleColor(
                start: Colors.green[300]!,
                end: Colors.green[300]!,
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Theme.of(context).colorScheme.secondary,
                dotSecondaryColor: Colors.green[300]!,
              ),
              likeCount: _numOfLike,
            ),
          if (widget.postPage)
            LikeButton(
              isLiked: _dislike,
              onTap: onDislikeButtonTapped,
              likeBuilder: (isLiked) {
                return Icon(
                  isLiked ? Icons.thumb_down_alt : Icons.thumb_down_off_alt,
                  color: isLiked ? Colors.red[300] : Colors.black54,
                );
              },
              circleColor: CircleColor(
                start: Colors.red[300]!,
                end: Colors.red[300]!,
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Theme.of(context).colorScheme.secondary,
                dotSecondaryColor: Colors.red[300]!,
              ),
              likeCount: _numOfDislike,
            ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('comments-page', arguments: {
                'postOrAdvice': widget.postPage,
                'postId': widget.postId,
              });
            },
            label: Text(
              _numOfComments.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            icon: const Icon(
              Icons.chat_outlined,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
