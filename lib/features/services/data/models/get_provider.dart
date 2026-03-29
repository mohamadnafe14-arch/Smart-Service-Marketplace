import 'dart:convert';

class GetProvider {
  int? id;
  String? name;
  String? role;
  String? phone;
  String? category;
  int? rating;

  GetProvider({
    this.id,
    this.name,
    this.role,
    this.phone,
    this.category,
    this.rating,
  });

  factory GetProvider.fromMap(Map<String, dynamic> data) => GetProvider(
    id: data['id'] as int?,
    name: data['name'] as String?,
    role: data['role'] as String?,
    phone: data['phone'] as String?,
    category: data['category'] as String?,
    rating: data['rating'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'role': role,
    'phone': phone,
    'category': category,
    'rating': rating,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetProvider].
  factory GetProvider.fromJson(String data) {
    return GetProvider.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetProvider] to a JSON string.
  String toJson() => json.encode(toMap());
}
