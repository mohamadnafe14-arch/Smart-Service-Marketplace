import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.onDelete,
    required this.onRetry,
  });

  final ChatMessage message;
  final VoidCallback onDelete;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    final time = _time(message.createdAt);
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: isSender && !message.isSending && !message.hasFailed
            ? () => _confirmDelete(context)
            : null,
        onTap: message.hasFailed ? onRetry : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * .76,
          ),
          child: Container(
            margin: EdgeInsets.only(
              left: isSender ? 54 : 0,
              right: isSender ? 0 : 54,
              bottom: 9,
            ),
            padding: const EdgeInsets.fromLTRB(14, 10, 13, 8),
            decoration: BoxDecoration(
              color: message.hasFailed
                  ? const Color(0xFFFFF0ED)
                  : isSender
                  ? const Color(0xFF087E78)
                  : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isSender ? 18 : 5),
                bottomRight: Radius.circular(isSender ? 5 : 18),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x080C3532),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                    color: message.hasFailed
                        ? const Color(0xFFB33D2D)
                        : isSender
                        ? Colors.white
                        : const Color(0xFF203937),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (message.hasFailed) ...[
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 13,
                        color: Color(0xFFB33D2D),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Tap to retry',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFB33D2D),
                        ),
                      ),
                    ] else ...[
                      Text(
                        time,
                        style: TextStyle(
                          color: isSender
                              ? Colors.white70
                              : const Color(0xFF91A09E),
                          fontSize: 10,
                        ),
                      ),
                      if (isSender) ...[
                        const SizedBox(width: 5),
                        if (message.isSending)
                          Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: Colors.white.withValues(alpha: .75),
                          )
                        else
                          Icon(
                            message.status == 'read'
                                ? Icons.done_all_rounded
                                : message.status == 'delivered'
                                ? Icons.done_all_rounded
                                : Icons.done_rounded,
                            size: 15,
                            color: message.status == 'read'
                                ? const Color(0xFF9FE8E0)
                                : Colors.white70,
                          ),
                      ],
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _time(String? value) {
    final date = DateTime.tryParse(value ?? '')?.toLocal();
    if (date == null) return '';
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this message?'),
        content: const Text(
          'This message will be removed from the conversation.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFB33D2D)),
            ),
          ),
        ],
      ),
    );
    if (shouldDelete == true) onDelete();
  }
}
