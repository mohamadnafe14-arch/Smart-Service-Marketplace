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
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      createdSince: json['createdSince'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      statistics: Statistics.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
    );
  }
}
