import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/auth/view/widgets/dot.dart';

class ThreeDots extends StatelessWidget {
  const ThreeDots({
    super.key,
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        double progress = animation.value;
        double segment = progress * 3;
        bool isActive = segment > index;
        return Dot(isActive: isActive);
      }),
    );
  }
}