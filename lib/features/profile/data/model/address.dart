class Address {
  final String city, street, addressInDetails;

  Address({
    required this.city,
    required this.street,
    required this.addressInDetails,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] as String,
      street: json['street'] as String,
      addressInDetails: json['addressInDetails'] as String,
    );
  }
}
