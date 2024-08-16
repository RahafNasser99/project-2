import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/logout/presentation/cubit/logout_cubit.dart';
import 'package:law_platform_flutter/features/logout/presentation/widgets/logout_dialog_widget.dart';
import 'package:law_platform_flutter/utils/global_classes/configurations.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ListTile(
              trailing: CircleAvatar(
                backgroundImage: checkAuthentication.getImage().isNotEmpty
                    ? NetworkImage(
                        '$BASE_URL/${checkAuthentication.getImage()}')
                    : null,
                child: checkAuthentication.getImage().isEmpty
                    ? Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              contentPadding: const EdgeInsets.only(left: 20.0),
              title: Text(
                checkAuthentication.getName(),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  'profile-page',
                  arguments: {
                    'userId': null,
                    'accountType': null,
                  },
                );
              },
            ),
            const Divider(),
            ListTile(
              iconColor: Colors.red,
              trailing: const Icon(Icons.logout),
              contentPadding: const EdgeInsets.only(left: 40.0),
              title: Text(
                'تسجيل الخروج',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider<LogoutCubit>(
                    create: (context) => LogoutCubit(),
                    child: const LogoutDialogWidget(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
