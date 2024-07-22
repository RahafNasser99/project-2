import 'package:flutter/material.dart';

class ShowProfilePicture extends StatelessWidget {
  final String image;
  final String name;

  const ShowProfilePicture({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Hero(
          tag: 'profile-name',
          child: Text(name,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 28,
                fontFamily: 'Lateef',
              )),
        ),
      ),
      body: Hero(
        tag: 'profile-picture',
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
