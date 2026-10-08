import 'package:flutter/material.dart';
import 'package:smart_service_market_place/features/chat/model/models/chat.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key, required this.chat, required this.onTap});

  final Chat chat;
  final VoidCallback onTap;

  static const _teal = Color(0xFF087E78);

  @override
  Widget build(BuildContext context) {
    final peer = chat.peer;
    final name = peer?.name.isNotEmpty == true ? peer!.name : 'Conversation';
    final preview = chat.lastMessage?.message ?? 'Start a conversation';
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _PeerAvatar(name: name, size: 54),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF172C2B),
                            ),
                          ),
                        ),
                        Text(
                          _formatTime(chat.lastMessageAt),
                          style: TextStyle(
                            fontSize: 11,
                            color: chat.unreadCount > 0
                                ? _teal
                                : const Color(0xFF8A9998),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            preview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: chat.unreadCount > 0
                                  ? const Color(0xFF334847)
                                  : const Color(0xFF849190),
                              fontWeight: chat.unreadCount > 0
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                        if (chat.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            constraints: const BoxConstraints(minWidth: 21),
                            height: 21,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: const BoxDecoration(
                              color: _teal,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              chat.unreadCount > 99
                                  ? '99+'
                                  : '${chat.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (peer?.category?.isNotEmpty == true) ...[
                      const SizedBox(height: 5),
                      Text(
                        peer!.category!,
                        style: const TextStyle(
                          color: _teal,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFA2B0AF)),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String? value) {
    final date = DateTime.tryParse(value ?? '')?.toLocal();
    if (date == null) return '';
    final now = DateTime.now();
    if (now.difference(date).inDays == 0 && date.day == now.day) {
      return '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}';
    }
    if (now.difference(date).inDays < 7) {
      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return weekdays[date.weekday - 1];
    }
    return '${date.day}/${date.month}';
  }
}

class _PeerAvatar extends StatelessWidget {
  const _PeerAvatar({required this.name, required this.size});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [Color(0xFF159A91), Color(0xFF075F5B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      name.trim().isEmpty ? '?' : name.trim().characters.first.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: size * .36,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
