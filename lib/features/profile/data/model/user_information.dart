import 'package:smart_service_marketplace/features/profile/data/model/address.dart';
import 'package:smart_service_marketplace/features/profile/data/model/statistics.dart';

class UserInformation {
  final String name;
  final String email;
  final String phone;
  final String createdSince;
  final Address address;
  final Statistics statistics;

  UserInformation({
    required this.name,
    required this.email,
    required this.phone,
    required this.createdSince,
    required this.address,
    required this.statistics,
  });
  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      name: json['name'] ?? "لم يتم تحديد الاسم",
      email: json['email'] ?? "لم يتم تحديد البريد الإلكتروني",
      phone: json['phone'] ?? "لم يتم تحديد الهاتف",
      createdSince: json['createdSince'] ?? "لم يتم تحديد تاريخ الإنشاء",
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      statistics: Statistics.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'createdSince': createdSince,
        'address': address.toJson(),
        'statistics': statistics.toJson(),
      };
}
