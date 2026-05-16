import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) => const ChatCard(),
      itemCount: 10,
    );
  }
}
