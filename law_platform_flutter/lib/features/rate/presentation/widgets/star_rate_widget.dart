import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class StarRateWidget extends StatefulWidget {
  const StarRateWidget(
      {super.key, required this.userId, required this.addRate});

  final int userId;
  final Future<void> Function(double) addRate;

  @override
  State<StarRateWidget> createState() => _StarRateWidgetState();
}

class _StarRateWidgetState extends State<StarRateWidget> {
  double _rate = 0;

  @override
  Widget build(BuildContext context) {
    return RatingStars(
      maxValueVisibility: true,
      valueLabelVisibility: false,
      value: _rate,
      onValueChanged: (newRate) async {
        //
        setState(() {
          _rate = newRate;
        });
        await widget.addRate(_rate).then(
          (value) {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) => Navigator.pop(context),
            );
          },
        );
      },
      starBuilder: (index, color) => Icon(
        Icons.star_rate_rounded,
        color: color,
      ),
      starCount: 5,
      starSize: 60,
      valueLabelColor: Theme.of(context).colorScheme.primary,
      maxValue: 5,
      starSpacing: 1,
      animationDuration: const Duration(milliseconds: 1000),
      valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: Colors.indigo.shade200,
      starColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
