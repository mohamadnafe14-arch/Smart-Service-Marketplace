class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.isSender,
    required this.message,
    required this.status,
    this.clientMsgId,
    this.deliveredAt,
    this.readAt,
    this.createdAt,
    this.createdAtHuman,
    this.isSending = false,
    this.hasFailed = false,
  });

  final int id;
  final int chatId;
  final int senderId;
  final bool isSender;
  final String message;
  final String status;
  final String? clientMsgId;
  final String? deliveredAt;
  final String? readAt;
  final String? createdAt;
  final String? createdAtHuman;
  final bool isSending;
  final bool hasFailed;

  factory ChatMessage.fromMap(Map<String, dynamic> map) => ChatMessage(
    id: map['id'] as int,
    chatId: map['chat_id'] as int,
    senderId: map['sender_id'] as int,
    isSender: map['is_sender'] as bool? ?? false,
    clientMsgId: map['client_msg_id'] as String?,
    message: map['message'] as String? ?? '',
    status: map['status'] as String? ?? 'sent',
    deliveredAt: map['delivered_at'] as String?,
    readAt: map['read_at'] as String?,
    createdAt: map['created_at'] as String?,
    createdAtHuman: map['created_at_human'] as String?,
  );

  ChatMessage copyWith({
    int? id,
    String? status,
    String? deliveredAt,
    String? readAt,
    bool? isSending,
    bool? hasFailed,
  }) => ChatMessage(
    id: id ?? this.id,
    chatId: chatId,
    senderId: senderId,
    isSender: isSender,
    message: message,
    status: status ?? this.status,
    clientMsgId: clientMsgId,
    deliveredAt: deliveredAt ?? this.deliveredAt,
    readAt: readAt ?? this.readAt,
    createdAt: createdAt,
    createdAtHuman: createdAtHuman,
    isSending: isSending ?? this.isSending,
    hasFailed: hasFailed ?? this.hasFailed,
  );
}
