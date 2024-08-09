import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:law_platform_flutter/features/profile/data/models/lawyer_profile_model.dart';
import 'package:law_platform_flutter/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/show_profile_picture.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/sticky_header_delegate.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/sliver_to_box_adapter_widget.dart';

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
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Column(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: height * 0.21,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.decal,
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.primary,
                      ],
                    ),
                  ),
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
                      child: Hero(
                        tag: 'profile-name',
                        child: ProfileInfoWidget(
                          width: width,
                          text: 'Rahaf Nasser',
                          icon: Icons.person_2_rounded,
                        ),
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
                    // SliverToBoxAdapter(
                    //   child: PostWidget(
                    //     post: PostModel(
                    //       postId: 1,
                    //       postBody: 'postBody',
                    //       postDate: DateTime.now(),
                    //       commentsCount: 20,
                    //       likesCount: 30,
                    //       dislikesCount: 60,
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: PostWidget(
                    //     post: PostModel(
                    //       postId: 1,
                    //       postBody: 'postBody',
                    //       postDate: DateTime.now(),
                    //       commentsCount: 20,
                    //       likesCount: 30,
                    //       dislikesCount: 60,
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: PostWidget(
                    //     post: PostModel(
                    //       postId: 1,
                    //       postBody: 'postBody',
                    //       postDate: DateTime.now(),
                    //       commentsCount: 20,
                    //       likesCount: 30,
                    //       dislikesCount: 60,
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: PostWidget(
                    //     post: PostModel(
                    //       postId: 1,
                    //       postBody: 'postBody',
                    //       postDate: DateTime.now(),
                    //       commentsCount: 20,
                    //       likesCount: 30,
                    //       dislikesCount: 60,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          Hero(
            tag: 'profile-picture',
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowProfilePicture(
                      image: 'assets/images/profile.png',
                      name: 'Rahaf Nasser',
                    ),
                  ),
                );
              },
              child: ProfilePictureWidget(
                radius: width * 0.15,
                margin: EdgeInsets.only(
                  top: height * 0.07,
                  right: 25,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              top: height * 0.195,
              left: 2.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: EditProfilePage(
                      profile: LawyerProfileModel(
                        id: 1,
                        name: 'name',
                        email: 'email',
                        profilePicture: null,
                        specialization: 'specialization',
                      ),
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: Icon(
                Icons.edit_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
