// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:smart_service_market_place/features/profile/model/models/address.dart';
import 'package:smart_service_market_place/features/profile/model/models/rating.dart';
import 'package:smart_service_market_place/features/profile/model/models/statistics.dart';
class UserInformation {
  final String name;
  final int id;
  final String email;
  final String? phone;
  final String createdSince;
  final Address address;
  final Statistics statistics;
  final Rating rating;
  final String? category;
  final String? experience;
  UserInformation({
    required this.name,
    required this.id,
    required this.email,
    this.phone,
    required this.createdSince,
    required this.address,
    required this.statistics,
    required this.rating,
    this.category,
    this.experience,
  });
  UserInformation copyWith({
    String? name,
    int? id,
    String? email,
    String? phone,
    String? createdSince,
    Address? address,
    Statistics? statistics,
    Rating? rating,
    String? category,
    String? experience,
  }) {
    return UserInformation(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdSince: createdSince ?? this.createdSince,
      address: address ?? this.address,
      statistics: statistics ?? this.statistics,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      experience: experience ?? this.experience,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'email': email,
      'phone': phone,
      'createdSince': createdSince,
      'address': address.toMap(),
      'statistics': statistics.toMap(),
      'rating': rating.toMap(),
      'category': category,
      'experience': experience,
    };
  }
  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      name: map['name'] as String,
      id: map['id'] as int,
      email: map['email'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdSince: map['createdSince'] as String,
      address: Address.fromMap(map['address'] as Map<String,dynamic>),
      statistics: Statistics.fromMap(map['statistics'] as Map<String,dynamic>),
      rating: Rating.fromMap(map['rating'] as Map<String,dynamic>),
      category: map['category'] != null ? map['category'] as String : null,
      experience: map['experience'] != null ? map['experience'] as String : null,
    );
  }
  String toJson() => json.encode(toMap());
  factory UserInformation.fromJson(String source) => UserInformation.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'UserInformation(name: $name, id: $id, email: $email, phone: $phone, createdSince: $createdSince, address: $address, statistics: $statistics, rating: $rating, category: $category, experience: $experience)';
  }
  @override
  bool operator ==(covariant UserInformation other) {
    if (identical(this, other)) return true;
    return 
      other.name == name &&
      other.id == id &&
      other.email == email &&
      other.phone == phone &&
      other.createdSince == createdSince &&
      other.address == address &&
      other.statistics == statistics &&
      other.rating == rating &&
      other.category == category &&
      other.experience == experience;
  }
  @override
  int get hashCode {
    return name.hashCode ^
      id.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      createdSince.hashCode ^
      address.hashCode ^
      statistics.hashCode ^
      rating.hashCode ^
      category.hashCode ^
      experience.hashCode;
  }
}