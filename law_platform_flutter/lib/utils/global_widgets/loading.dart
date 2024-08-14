import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.evenColor, required this.oddColor});

  final Color evenColor;
  final Color oddColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          SpinKitThreeInOut(
            itemBuilder: (BuildContext context, int index) {
              final color = index.isEven ? evenColor : oddColor;
              return DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              );
            },
          ),
        ],
      ),
    );
  }
}
