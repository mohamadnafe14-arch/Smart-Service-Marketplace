// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetProvider {
  final int? id;
  final String? name;
  final String? role;
  final String? phone;
  final String? category;
  final int? rating;
  GetProvider({
    this.id,
    this.name,
    this.role,
    this.phone,
    this.category,
    this.rating,
  });

  GetProvider copyWith({
    int? id,
    String? name,
    String? role,
    String? phone,
    String? category,
    int? rating,
  }) {
    return GetProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'phone': phone,
      'category': category,
      'rating': rating,
    };
  }

  factory GetProvider.fromMap(Map<String, dynamic> map) {
    return GetProvider(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetProvider.fromJson(String source) => GetProvider.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetProvider(id: $id, name: $name, role: $role, phone: $phone, category: $category, rating: $rating)';
  }

  @override
  bool operator ==(covariant GetProvider other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.role == role &&
      other.phone == phone &&
      other.category == category &&
      other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      role.hashCode ^
      phone.hashCode ^
      category.hashCode ^
      rating.hashCode;
  }
}
