class UserModel {
  final String email, name, token, role;
  final int id;

  UserModel({
    required this.email,
    required this.name,
    required this.token,
    required this.id,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      token: json['token'] ?? '',
      id: json['id'] ?? -1,
      role: json['role'] ?? '',
    );
  }
  UserModel copyWith({
    String? email,
    String? name,
    String? token,
    int? id,
    String? role,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'token': token,
    'id': id,
    'role': role,
  };
}
