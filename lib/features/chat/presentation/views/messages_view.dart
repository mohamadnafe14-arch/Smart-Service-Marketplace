import 'package:flutter/material.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_body.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/chat_bubble_for_friend.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/messages_body.dart';
import 'package:smart_service_marketplace/features/chat/presentation/views/widgets/messages_list.dart';

//TODO: وريها لما تخلص الواجهة بتاعت الشات
class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: MessagesBody(),
    );
  }
}
