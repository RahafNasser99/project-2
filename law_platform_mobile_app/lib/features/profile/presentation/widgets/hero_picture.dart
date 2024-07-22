import 'package:flutter/material.dart';

class HeroPicture extends StatelessWidget {
  final String image;
  final String name;

  const HeroPicture({
    super.key,
    required this.image,
    required this.name,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'profile-name',
          child: Text(
            name,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'profile-picture',
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
