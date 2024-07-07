import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:law_platform_mobile_app/features/posts_&_advices/presentation/widgets/post_widget.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/widgets/sticky_header_delegate.dart';
import 'package:law_platform_mobile_app/features/profile/presentation/widgets/sliver_to_box_adapter_widget.dart';

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
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: height * 0.21,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.inversePrimary,
                height: height * 0.79,
                padding: const EdgeInsets.only(top: 30),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapterWidget(
                      rightPadding: 12.0,
                      leftPadding: 12.0,
                      bottomPadding: 10.0,
                      child: ProfileInfoWidget(
                        width: width,
                        text: 'Rahaf Nasser',
                        icon: Icons.person_2_rounded,
                      ),
                    ),
                    SliverToBoxAdapterWidget(
                      rightPadding: 12.0,
                      leftPadding: 12.0,
                      bottomPadding: 10.0,
                      child: ProfileInfoWidget(
                        width: width,
                        text: 'rahaf@qanon.com',
                        icon: Icons.alternate_email_rounded,
                      ),
                    ),
                    SliverToBoxAdapterWidget(
                      rightPadding: 12.0,
                      leftPadding: 12.0,
                      bottomPadding: 30.0,
                      child: ProfileInfoWidget(
                        width: width,
                        text: 'lawyer',
                        icon: Icons.work_rounded,
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: StickyHeaderDelegate(
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
                    ),
                    // const SliverToBoxAdapter(
                    //   child: PostWidget(),
                    // ),
                    // const SliverToBoxAdapter(
                    //   child: PostWidget(),
                    // ),
                    // const SliverToBoxAdapter(
                    //   child: PostWidget(),
                    // ),
                    // const SliverToBoxAdapter(
                    //   child: PostWidget(),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          ProfilePictureWidget(width: width, height: height),
        ],
      ),
    );
  }
}
