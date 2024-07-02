import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.width,
    required this.text,
    required this.icon,
  });

  final double width;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          text,
          textDirection: TextDirection.rtl,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 25.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
