import 'package:smart_service_marketplace/features/profile/data/model/address.dart';
import 'package:smart_service_marketplace/features/profile/data/model/rating.dart';
import 'package:smart_service_marketplace/features/profile/data/model/statistics.dart';

class ProviderInformation {
  final String name;
  final String email;
  final String phone;
  final String createdSince;
  final Address address;
  final Statistics statistics;
  final Rating rating;

  ProviderInformation({
    required this.name,
    required this.email,
    required this.phone,
    required this.createdSince,
    required this.address,
    required this.statistics,
    required this.rating,
  });
  factory ProviderInformation.fromJson(Map<String, dynamic> json) {
    return ProviderInformation(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      createdSince: json['createdSince'],
      address: Address.fromJson(json['address']),
      statistics: Statistics.fromJson(json['statistics']),
      rating: Rating.fromJson(json['rating']),
    );
  }
}
