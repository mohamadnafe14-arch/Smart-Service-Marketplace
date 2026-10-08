import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatMessageShimmer extends StatelessWidget {
  const ChatMessageShimmer({super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
    padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
    itemCount: 6,
    itemBuilder: (context, index) {
      final isRight = index.isEven;
      return Align(
        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE6ECEB),
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            width: 150 + (index % 3) * 35,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      );
    },
  );
}
