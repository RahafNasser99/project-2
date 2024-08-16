import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/search/presentation/cubit/search_cubit.dart';
import 'package:law_platform_flutter/utils/global_widgets/list_tile_widget.dart';
import 'package:law_platform_flutter/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:law_platform_flutter/utils/global_widgets/loading.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    Future<void> search(String searchQuery) async {
      await BlocProvider.of<SearchCubit>(context).search(searchQuery);
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: (height - statusBarHeight - 12) * 0.06,
            margin: EdgeInsets.only(
              top: statusBarHeight + 6.0,
              bottom: 6.0,
              right: 8.0,
              left: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: (width - 12) * 0.08,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
                SizedBox(
                  width: (width - 12) * 0.92,
                  child: SearchBarWidget(
                    search: search,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {
                if (state is SearchError) {
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
                if (state is SearchLoading) {
                  return Center(
                    child: Loading(
                      evenColor: Theme.of(context).colorScheme.primary,
                      oddColor: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                } else if (state is SearchEmpty) {
                  return Center(
                    child: Text(
                      'لا يوجد مستخدمين بهذا الاسم أو الاختصاص',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                } else if (state is SearchLoading) {
                  return Center(
                    child: Loading(
                      evenColor: Theme.of(context).colorScheme.primary,
                      oddColor: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                } else if (state is SearchDone) {
                  return ListView.builder(
                    itemCount: state.profiles.length,
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
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
