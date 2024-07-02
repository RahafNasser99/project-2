import 'package:flutter/material.dart';

class SliverToBoxAdapterWidget extends StatelessWidget {
  const SliverToBoxAdapterWidget({
    super.key,
    required this.rightPadding,
    required this.leftPadding,
    required this.bottomPadding,
    required this.child,
  });

  final double rightPadding;
  final double leftPadding;
  final double bottomPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          right: rightPadding,
          left: leftPadding,
          bottom: bottomPadding,
        ),
        child: child,
      ),
    );
  }
}
