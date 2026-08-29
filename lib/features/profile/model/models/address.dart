// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Address {
  final String? city;
  final String? street;
  final String? addressInDetails;
  Address({
    this.city,
    this.street,
    this.addressInDetails,
  });

  Address copyWith({
    String? city,
    String? street,
    String? addressInDetails,
  }) {
    return Address(
      city: city ?? this.city,
      street: street ?? this.street,
      addressInDetails: addressInDetails ?? this.addressInDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'street': street,
      'addressInDetails': addressInDetails,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      city: map['city'] != null ? map['city'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      addressInDetails: map['addressInDetails'] != null ? map['addressInDetails'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Address(city: $city, street: $street, addressInDetails: $addressInDetails)';

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;
  
    return 
      other.city == city &&
      other.street == street &&
      other.addressInDetails == addressInDetails;
  }

  @override
  int get hashCode => city.hashCode ^ street.hashCode ^ addressInDetails.hashCode;
}
