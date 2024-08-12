import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:law_platform_flutter/utils/global_widgets/loading.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/lawyer_profile.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/member_profile.dart';
import 'package:law_platform_flutter/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/show_profile_picture.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/profile_picture_widget.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/sticky_header_delegate.dart';
import 'package:law_platform_flutter/features/profile/presentation/widgets/sliver_to_box_adapter_widget.dart';
import 'package:law_platform_flutter/features/profile/presentation/cubits/get_profile_cubit/get_profile_cubit.dart';
import 'package:law_platform_flutter/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      await BlocProvider.of<GetProfileCubit>(context).getProfile();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: BlocConsumer<GetProfileCubit, GetProfileState>(
        listener: (context, state) {
          if (state is GetProfileError) {
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
          if (state is GetProfileLoading) {
            return Center(
              child: Loading(
                evenColor: Theme.of(context).colorScheme.primary,
                oddColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else if (state is GetProfileDone) {
            return Stack(
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
                                text: state.profile.name,
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
                              text: state.profile.email,
                              icon: Icons.alternate_email_rounded,
                            ),
                          ),
                          if ((checkAuthentication.getAccountType() ==
                                      'member' &&
                                  (state.profile as MemberProfile).job !=
                                      null) ||
                              (checkAuthentication.getAccountType() ==
                                      'lawyer' &&
                                  (state.profile as LawyerProfile)
                                          .specialization !=
                                      null))
                            SliverToBoxAdapterWidget(
                              rightPadding: 12.0,
                              leftPadding: 12.0,
                              bottomPadding: 30.0,
                              child: ProfileInfoWidget(
                                width: width,
                                text: checkAuthentication.getAccountType() ==
                                        'member'
                                    ? (state.profile as MemberProfile).job!
                                    : (state.profile as LawyerProfile)
                                        .specialization!,
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
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
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
                        ],
                      ),
                    ),
                  ],
                ),
                if (state.profile.profilePicture != null)
                  Hero(
                    tag: 'profile-picture',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowProfilePicture(
                              imageUrl: state.profile.profilePicture!,
                              name: state.profile.name,
                            ),
                          ),
                        );
                      },
                      child: state.profile.profilePicture != null
                          ? ProfilePictureWidget(
                              radius: width * 0.15,
                              margin: EdgeInsets.only(
                                top: height * 0.07,
                                right: 25,
                              ),
                              backgroundImage:
                                  NetworkImage(state.profile.profilePicture!),
                            )
                          : Icon(
                              Icons.person_rounded,
                              color: Theme.of(context).colorScheme.primary,
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
                      Navigator.of(context).pushReplacement(
                        PageTransition(
                          child: BlocProvider<EditProfileCubit>(
                            create: (context) => EditProfileCubit(),
                            child: EditProfilePage(
                              profile: state.profile,
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
