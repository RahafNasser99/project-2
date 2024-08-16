import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law_platform_flutter/features/login_&_signup/presentation/pages/login_page.dart';
import 'package:law_platform_flutter/features/logout/presentation/cubit/logout_cubit.dart';
import 'package:law_platform_flutter/utils/global_widgets/alert_dialog_widget.dart';
import 'package:law_platform_flutter/utils/global_widgets/loading.dart';
import 'package:law_platform_flutter/utils/global_widgets/show_dialog.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          return AlertDialogWidget(
            alertTitle: 'تسجيل الخروج',
            alertContent: 'تأكيد تسجيل الخروج',
            onPressed: () async {
              // delete token
              await BlocProvider.of<LogoutCubit>(context).logout();
            },
          );
        }
      },
    );
  }
}
