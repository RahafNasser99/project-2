import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_mobile_app/features/login_&_signup/presentation/pages/login_page.dart';
import 'package:law_platform_mobile_app/features/logout/presentation/cubit/logout_cubit.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/loading.dart';
import 'package:law_platform_mobile_app/utils/global_widgets/show_dialog.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutError) {
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
        } else if (state is LogoutDone) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              'login-page', (route) => route is LoginPage);
        }
      },
      builder: (context, state) {
        if (state is LogoutLoading) {
          return Loading(
            evenColor: Theme.of(context).colorScheme.primary,
            oddColor: Theme.of(context).colorScheme.secondary,
          );
        } else {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: const Text(
              'تسجيل الخروج',
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Lateef',
              fontWeight: FontWeight.bold,
            ),
            content: Text(
              'تأكيد تسجيل الخروج',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(width / 4),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'الغاء',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // delete token
                  await BlocProvider.of<LogoutCubit>(context).logout();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(width / 4),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'تأكيد',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 20,
                    fontFamily: 'Lateef',
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
