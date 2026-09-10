// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  final String status;
  final String phoneUser;
  final String providerName;
  final String description;
  final String userName;
  final String updatedAt;
  final double rating;
  final int userId;
  final int providerId;
  final int id;
  OrderModel({
    required this.status,
    required this.phoneUser,
    required this.providerName,
    required this.description,
    required this.userName,
    required this.updatedAt,
    required this.rating,
    required this.userId,
    required this.providerId,
    required this.id,
  });

  OrderModel copyWith({
    String? status,
    String? phoneUser,
    String? providerName,
    String? description,
    String? userName,
    String? updatedAt,
    double? rating,
    int? userId,
    int? providerId,
    int? id,
  }) {
    return OrderModel(
      status: status ?? this.status,
      phoneUser: phoneUser ?? this.phoneUser,
      providerName: providerName ?? this.providerName,
      description: description ?? this.description,
      userName: userName ?? this.userName,
      updatedAt: updatedAt ?? this.updatedAt,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'phoneUser': phoneUser,
      'providerName': providerName,
      'description': description,
      'userName': userName,
      'updatedAt': updatedAt,
      'rating': rating,
      'userId': userId,
      'providerId': providerId,
      'id': id,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      status: map['status'],
      phoneUser: map['phone_user'],
      providerName: map['provider_name'],
      description: map['description'],
      userName: map['user_name'],
      updatedAt: map['updated_at'],
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : 0.0,
      userId: map['user_id'],
      providerId: map['provider_id'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(status: $status, phoneUser: $phoneUser, providerName: $providerName, description: $description, userName: $userName, updatedAt: $updatedAt, rating: $rating, userId: $userId, providerId: $providerId, id: $id)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.phoneUser == phoneUser &&
        other.providerName == providerName &&
        other.description == description &&
        other.userName == userName &&
        other.updatedAt == updatedAt &&
        other.rating == rating &&
        other.userId == userId &&
        other.providerId == providerId &&
        other.id == id;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        phoneUser.hashCode ^
        providerName.hashCode ^
        description.hashCode ^
        userName.hashCode ^
        updatedAt.hashCode ^
        rating.hashCode ^
        userId.hashCode ^
        providerId.hashCode ^
        id.hashCode;
  }
}
