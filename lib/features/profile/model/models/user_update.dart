// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserUpdate {
  final String? name;
  final String? phone;
  final String? city;
  final String? street;
  final String? addressInDetails;
  final String? category;
  final String? experience;
  UserUpdate({
    this.name,
    this.phone,
    this.city,
    this.street,
    this.addressInDetails,
    this.category,
    this.experience,
  });

  UserUpdate copyWith({
    String? name,
    String? phone,
    String? city,
    String? street,
    String? addressInDetails,
    String? category,
    String? experience,
  }) {
    return UserUpdate(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      street: street ?? this.street,
      addressInDetails: addressInDetails ?? this.addressInDetails,
      category: category ?? this.category,
      experience: experience ?? this.experience,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
      if (street != null) 'street': street,
      if (addressInDetails != null) 'addressInDetails': addressInDetails,
      if (category != null) 'category': category,
      if (experience != null) 'experience': experience,
    };
  }

  factory UserUpdate.fromMap(Map<String, dynamic> map) {
    return UserUpdate(
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      addressInDetails: map['addressInDetails'] != null
          ? map['addressInDetails'] as String
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      experience: map['experience'] != null
          ? map['experience'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserUpdate.fromJson(String source) =>
      UserUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserUpdate(name: $name, phone: $phone, city: $city, street: $street, addressInDetails: $addressInDetails, category: $category, experience: $experience)';
  }

  @override
  bool operator ==(covariant UserUpdate other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.city == city &&
        other.street == street &&
        other.addressInDetails == addressInDetails &&
        other.category == category &&
        other.experience == experience;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        city.hashCode ^
        street.hashCode ^
        addressInDetails.hashCode ^
        category.hashCode ^
        experience.hashCode;
  }
}
