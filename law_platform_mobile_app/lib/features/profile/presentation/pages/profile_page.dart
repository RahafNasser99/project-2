import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/widgets/post_widget.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/widgets/profile_info_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: height * 0.25,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Container(
                    color: Colors.grey[100],
                    height: height * 0.75,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 12.0,
                              left: 12.0,
                              top: 40,
                            ),
                            child: ProfileInfoWidget(
                              width: width,
                              text: 'Rahaf Nasser',
                              icon: Icons.person_2_rounded,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10.0,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 12.0,
                              left: 12.0,
                              bottom: 12.0,
                            ),
                            child: ProfileInfoWidget(
                              width: width,
                              text: 'rahaf@qanon.com',
                              icon: Icons.alternate_email_rounded,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 20.0,
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _StickyHeaderDelegate(
                            child: Container(
                              color: Colors.grey[100],
                              height: 30.0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Text(
                                  'المنشورات',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: PostWidget(),
                        ),
                        const SliverToBoxAdapter(
                          child: PostWidget(),
                        ),
                        const SliverToBoxAdapter(
                          child: PostWidget(),
                        ),
                        const SliverToBoxAdapter(
                          child: PostWidget(),
                        ),
                      ],
                    )

                    //  SingleChildScrollView(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: <Widget>[
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //           right: 12.0,
                    //           left: 12.0,
                    //           top: 40,
                    //         ),
                    //         child: ProfileInfoWidget(
                    //           width: width,
                    //           text: 'Rahaf Nasser',
                    //           icon: Icons.person_2_rounded,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10.0,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //           right: 12.0,
                    //           left: 12.0,
                    //           bottom: 12.0,
                    //         ),
                    //         child: ProfileInfoWidget(
                    //           width: width,
                    //           text: 'rahaf@qanon.com',
                    //           icon: Icons.alternate_email_rounded,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 20.0,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(right: 6.0),
                    //         child: Text(
                    //           'المنشورات',
                    //           style: Theme.of(context).textTheme.bodyLarge,
                    //         ),
                    //       ),
                    //       PostWidget(),
                    //       PostWidget(),
                    //       PostWidget(),
                    //       PostWidget(),

                    //       // Expanded(
                    //       //   child: ListView.builder(
                    //       //     itemCount: 5,
                    //       //     itemBuilder: (context, index) => const PostWidget(),
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(
                top: height * 0.1,
                right: 25,
              ),
              child: CircleAvatar(
                radius: width * 0.15,
                backgroundColor: Colors.indigo[100],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child is PreferredSizeWidget
      ? (child as PreferredSizeWidget).preferredSize.height
      : 30.0;

  @override
  double get minExtent => child is PreferredSizeWidget
      ? (child as PreferredSizeWidget).preferredSize.height
      : 30.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
