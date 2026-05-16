import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_list.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});
  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [ChatList(scrollController: _scrollController)],
    );
  }
}
