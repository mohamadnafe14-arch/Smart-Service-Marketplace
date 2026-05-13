import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_list.dart'; 
class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [ChatList()]);
  }
}