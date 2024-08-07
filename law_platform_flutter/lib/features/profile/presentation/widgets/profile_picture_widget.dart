import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.margin,
    required this.radius,
    required this.backgroundImage,
  });

  final double radius;
  final EdgeInsetsGeometry? margin;
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: margin,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 2.5,
              spreadRadius: 1.5,
            )
          ],
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: backgroundImage,
        ),
      ),
    );
  }
}
