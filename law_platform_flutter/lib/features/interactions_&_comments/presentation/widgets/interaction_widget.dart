import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/interaction_cubit/interaction_cubit.dart';

class InteractionWidget extends StatefulWidget {
  const InteractionWidget({
    super.key,
    required this.postPage,
    required this.postId,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.userInteraction,
  });

  final bool postPage;
  final int postId;
  final int likes;
  final int dislikes;
  final int comments;
  final bool? userInteraction;

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
    _like = widget.userInteraction != null && widget.userInteraction!
        ? true
        : false;
    _dislike = widget.userInteraction != null && !widget.userInteraction!
        ? true
        : false;
    _numOfLike = widget.likes;
    _numOfDislike = widget.dislikes;
    _numOfComments = widget.comments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    // interaction is true for like, false for dislike
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      // like is false and like button tapped
      if (!_like) {
        BlocProvider.of<InteractionCubit>(context)
            .addOrRemoveInteraction('add', true, widget.postId);
      } else {
        BlocProvider.of<InteractionCubit>(context)
            .addOrRemoveInteraction('remove', true, widget.postId);
      }

      setState(() {
        _like = !_like;
        if (_like) {
          _dislike = false;
          _numOfLike++;
        } else {
          _numOfLike--;
        }
      });

      return !isLiked;
    }

    void onLikePostError() {
      setState(() {
        _like = !_like;
        if (!_like) {
          _dislike = false;
          _numOfLike--;
        }
      });
    }

// interaction is true for like, false for dislike
    Future<bool> onDislikeButtonTapped(bool isLiked) async {
      // dislike is false and dislike button tapped
      if (!_dislike) {
        BlocProvider.of<InteractionCubit>(context)
            .addOrRemoveInteraction('add', false, widget.postId);
      } else {
        BlocProvider.of<InteractionCubit>(context)
            .addOrRemoveInteraction('remove', false, widget.postId);
      }

      setState(() {
        _dislike = !_dislike;
        if (_dislike) {
          _like = false;
          _numOfDislike++;
        } else {
          _numOfDislike--;
        }
      });

      return !isLiked;
    }

    void onDisLikePostError() {
      setState(
        () {
          _dislike = !_dislike;
          if (_dislike) {
            _like = false;
            _numOfDislike--;
          }
        },
      );
    }

    return BlocConsumer<InteractionCubit, InteractionState>(
      listener: (context, state) {
        if (state is InteractionError) {
          if (_like) {
            onLikePostError();
          } else {
            onDisLikePostError();
          }
        } else if (state is InteractionDone) {}
      },
      builder: (context, state) {
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
      },
    );
  }
}
