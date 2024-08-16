import 'package:flutter/material.dart';
import 'package:law_platform_flutter/features/rate/presentation/widgets/star_rate_widget.dart';

class RateWidget {
  final int userId;
  Future<void> Function(double) addRate;

  RateWidget({required this.userId, required this.addRate});

  showRateModelBottomSheet(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: height / 3,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            )),
        width: double.infinity,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ما هو تقييمك؟',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            StarRateWidget(
              userId: userId,
              addRate: addRate,
            ),
          ],
        )),
      ),
    );
  }
}
