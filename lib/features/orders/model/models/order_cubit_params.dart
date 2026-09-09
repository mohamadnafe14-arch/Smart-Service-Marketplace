// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderCubitParams {
  final String token;
  final String id;
  final String role;
  OrderCubitParams({
    required this.token,
    required this.id,
    required this.role,
  });

  OrderCubitParams copyWith({
    String? token,
    String? id,
    String? role,
  }) {
    return OrderCubitParams(
      token: token ?? this.token,
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'role': role,
    };
  }

  factory OrderCubitParams.fromMap(Map<String, dynamic> map) {
    return OrderCubitParams(
      token: map['token'] as String,
      id: map['id'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderCubitParams.fromJson(String source) => OrderCubitParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderCubitParams(token: $token, id: $id, role: $role)';

  @override
  bool operator ==(covariant OrderCubitParams other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.id == id &&
      other.role == role;
  }

  @override
  int get hashCode => token.hashCode ^ id.hashCode ^ role.hashCode;
}
