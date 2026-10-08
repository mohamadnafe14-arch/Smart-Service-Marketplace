class ChatPeer {
  const ChatPeer({
    required this.id,
    required this.name,
    required this.role,
    this.phone,
    this.category,
    this.rate,
    this.lastSeenAt,
  });

  final int id;
  final String name;
  final String role;
  final String? phone;
  final String? category;
  final double? rate;
  final String? lastSeenAt;

  factory ChatPeer.fromMap(Map<String, dynamic> map) => ChatPeer(
    id: map['id'] as int,
    name: map['name'] as String? ?? '',
    role: map['role'] as String? ?? '',
    phone: map['phone'] as String?,
    category: map['category'] as String?,
    rate: (map['rate'] as num?)?.toDouble(),
    lastSeenAt: map['last_seen_at'] as String?,
  );
}
