import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => const ChatCard(),
      itemCount: 10,
    );
  }
}
