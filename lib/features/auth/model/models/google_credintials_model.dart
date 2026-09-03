// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GoogleCredintialsModel {
  final String id_token;
  final String email;
  GoogleCredintialsModel({required this.id_token, required this.email});

  GoogleCredintialsModel copyWith({String? id_token, String? email}) {
    return GoogleCredintialsModel(
      id_token: id_token ?? this.id_token,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id_token': id_token, 'email': email};
  }

  factory GoogleCredintialsModel.fromMap(Map<String, dynamic> map) {
    return GoogleCredintialsModel(
      id_token: map['id_token'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GoogleCredintialsModel.fromJson(String source) =>
      GoogleCredintialsModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'GoogleCredintialsModel(id_token: $id_token, email: $email)';

  @override
  bool operator ==(covariant GoogleCredintialsModel other) {
    if (identical(this, other)) return true;

    return other.id_token == id_token && other.email == email;
  }

  @override
  int get hashCode => id_token.hashCode ^ email.hashCode;
}
