import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_bubble_for_friend.dart';
//TODO: وريها لما تخلص الواجهة بتاعت الشات
class MessagesList extends StatelessWidget {
  const MessagesList({super.key, required this.scrollController});
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      reverse: true,
      itemBuilder: (context, index) {
        if (index % 2 == 0) {
          return ChatBubble(message: "I don't know", time: "12:00 PM");
        } else {
          return FriendChatBubble(message: "Hello!", time: "12:01 PM");
        }
      },
      itemCount: 20,
    );
  }
}
