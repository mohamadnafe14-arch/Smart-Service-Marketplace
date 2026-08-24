// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GoogleCredintialsModel {
  final String token;
  final String email;
  GoogleCredintialsModel({
    required this.token,
    required this.email,
  });

  GoogleCredintialsModel copyWith({
    String? token,
    String? email,
  }) {
    return GoogleCredintialsModel(
      token: token ?? this.token,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
    };
  }

  factory GoogleCredintialsModel.fromMap(Map<String, dynamic> map) {
    return GoogleCredintialsModel(
      token: map['token'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleCredintialsModel.fromJson(String source) => GoogleCredintialsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GoogleCredintialsModel(token: $token, email: $email)';

  @override
  bool operator ==(covariant GoogleCredintialsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.email == email;
  }

  @override
  int get hashCode => token.hashCode ^ email.hashCode;
}
