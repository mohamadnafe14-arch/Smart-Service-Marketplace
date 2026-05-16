class Message {
  final int id;
  final String content;
  final int senderId;
  final String time;
  final bool read;
  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.time,
    required this.read,
  });
  Message copyWith({
    int? id,
    String? content,
    int? senderId,
    String? time,
    bool? read,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      time: time ?? this.time,
      read: read ?? this.read,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      senderId: json['sender_id'],
      time: json['time'],
      read: json['read'],
    );
  }
 
}
