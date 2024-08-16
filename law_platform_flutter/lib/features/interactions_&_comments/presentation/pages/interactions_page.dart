import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_flutter/utils/global_widgets/list_tile_widget.dart';
import 'package:law_platform_flutter/features/interactions_&_comments/presentation/cubits/get_interactions_cubit/get_interactions_cubit.dart';

class InteractionsPage extends StatefulWidget {
  const InteractionsPage(
      {super.key, required this.likeOrDislike, required this.postId});

  final bool likeOrDislike;
  final int postId;

  @override
  State<InteractionsPage> createState() => _InteractionsPageState();
}

class _InteractionsPageState extends State<InteractionsPage> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      BlocProvider.of<GetInteractionsCubit>(context)
          .getInteractions(widget.postId, widget.likeOrDislike);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التفاعلات',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<GetInteractionsCubit, GetInteractionsState>(
            listener: (context, state) {
              if (state is GetInteractionsError) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ShowDialog(
                    dialogMessage: state.errorMessage,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetInteractionsLoading) {
                return Expanded(
                  child: Center(
                    child: Icon(
                      widget.likeOrDislike
                          ? Icons.thumb_up_alt
                          : Icons.thumb_down_alt,
                      size: 60,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                );
              } else if (state is GetInteractionsEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'لا يوجد تفاعلات لعرضها',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                );
              } else if (state is GetInteractionsDone) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.profiles.length,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder: (context, index) => ListTileWidget(
                      profile: state.profiles[index],
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          'profile-page',
                          arguments: {
                            'userId': state.profiles[index].id,
                            'accountType': state.profiles[index].accountType,
                          },
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
