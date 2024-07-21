import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    //  required this.width,
    //  required this.height,
    required this.margin,
    required this.radius,
  });

  // final double width;
  // final double height;
  final double radius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: margin,
      //  EdgeInsets.only(
      //   top: height * 0.07,
      //   right: 25,
      // ),
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
          backgroundImage: const AssetImage('assets/images/profile.png'),
        ),
      ),
    );
  }
}
