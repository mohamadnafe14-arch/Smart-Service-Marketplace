import 'package:smart_service_market_place/features/chat/model/models/chat.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_cubit_params.dart';

class ChatConversationArgs {
  const ChatConversationArgs({
    required this.params,
    this.chat,
    this.providerId,
  });

  final ChatCubitParams params;
  final Chat? chat;
  final int? providerId;
}
