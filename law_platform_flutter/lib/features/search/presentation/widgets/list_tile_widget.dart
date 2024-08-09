import 'package:flutter/material.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/lawyer_profile.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/member_profile.dart';
import 'package:law_platform_flutter/features/profile/domain/entities/profile.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
          profile.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: (checkAuthentication.getAccountType() == 'member' &&
                (profile as MemberProfile).job != null)
            ? Text((profile as MemberProfile).job!,
                style: Theme.of(context).textTheme.headlineSmall)
            : (profile as LawyerProfile).specialization != null
                ? Text((profile as LawyerProfile).specialization!,
                    style: Theme.of(context).textTheme.headlineSmall)
                : null,
      ),
    );
  }
}
