class User {
  final String email, name, token, role;
  final int id;

  User({
    required this.email,
    required this.name,
    required this.token,
    required this.id,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      token: json['token'] ?? '',
      id: json['id'] ?? -1,
      role: json['role'] ?? '',
    );
  }
  User copyWith({
    String? email,
    String? name,
    String? token,
    int? id,
    String? role,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }
}
