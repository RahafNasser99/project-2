import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    super.key,
    this.onPressed,
    required this.alertTitle,
    required this.alertContent,
  });

  final void Function()? onPressed;
  final String alertTitle;
  final String alertContent;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        alertTitle,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontFamily: 'Lateef',
        fontWeight: FontWeight.bold,
      ),
      content: Text(
        alertContent,
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
          onPressed: onPressed,
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
}
