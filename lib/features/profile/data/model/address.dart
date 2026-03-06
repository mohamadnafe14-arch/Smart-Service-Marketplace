class Address {
  final String city, street, addressInDetails;
  Address({
    required this.city,
    required this.street,
    required this.addressInDetails,
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? "لم يتم تحديد المدينة",
      street: json['street'] ?? "لم يتم تحديد الشارع",
      addressInDetails: json['addressInDetails'] ?? "لم يتم تحديد التفاصيل",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "city": city,
      "street": street,
      "addressInDetails": addressInDetails,
    };
  }
}
