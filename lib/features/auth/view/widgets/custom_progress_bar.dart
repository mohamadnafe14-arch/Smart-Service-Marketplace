import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.animation,
  });

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: animation.value,
        minHeight: 8,
        backgroundColor: Colors.white24,
        valueColor: const AlwaysStoppedAnimation(
          Colors.lightBlueAccent,
        ),
      ),
    );
  }
}