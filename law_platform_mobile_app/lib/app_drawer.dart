import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_mobile_app/features/logout/presentation/cubit/logout_cubit.dart';
import 'package:law_platform_mobile_app/features/logout/presentation/widgets/logout_dialog_widget.dart';

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
                backgroundColor: Colors.grey[600],
                maxRadius: 18,
              ),
              contentPadding: const EdgeInsets.only(left: 20.0),
              title: Text(
                'Rahaf Nasser',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('profile-page');
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
