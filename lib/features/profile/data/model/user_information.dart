import 'package:smart_service_marketplace/features/profile/data/model/address.dart';
import 'package:smart_service_marketplace/features/profile/data/model/rating.dart';
import 'package:smart_service_marketplace/features/profile/data/model/statistics.dart';

class UserInformation {
  final String name;
  final int id;
  final String email;
  final String phone;
  final String createdSince;
  final Address address;
  final Statistics statistics;
  final Rating rating;
  final String category;
  final String experience;
  UserInformation({
    required this.name,
    required this.email,
    required this.phone,
    required this.createdSince,
    required this.address,
    required this.statistics,
    required this.rating,
    required this.category,
    required this.experience,
    required this.id,
  });
  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      name: json['name'] ?? "لم يتم تحديد الاسم",
      email: json['email'] ?? "لم يتم تحديد البريد الإلكتروني",
      phone: json['phone'] ?? "لم يتم تحديد الهاتف",
      createdSince: json['createdSince'] ?? "لم يتم تحديد تاريخ الإنشاء",
      address: Address.fromJson(json['address'] ?? {}),
      statistics: Statistics.fromJson(json['statistics'] ?? {}),
      rating: Rating.fromJson(json['rating'] ?? {}),
      category: json['category'] ?? "لم يتم تحديد الفئة",
      experience: json['experiences'] ?? "لم يتم تحديد الخبرة",
      id: json['id'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'createdSince': createdSince,
    'address': address.toJson(),
    'statistics': statistics.toJson(),
    'rating': rating.toJson(),
    'category': category,
    'experience': experience,
  };
}
