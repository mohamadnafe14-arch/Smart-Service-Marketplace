class OrderModel {
  final String status;
  final String phoneUser;
  final String providerName;
  final String description; 
  final String userName;
  final String updatedAt;
  final double rating;

 const OrderModel({
    required this.status,
    required this.phoneUser,
    required this.providerName,
    required this.description,
    required this.userName,
    required this.updatedAt,
    required this.rating,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'],
      phoneUser: json['phone_user'],
      providerName: json['provider_name'],
      description: json['description'],
      userName: json['user_name'],
      updatedAt: json['updated_at'],
      rating: json['rating'],
    );
  }
  OrderModel copyWith({
    String? status,
    String? phoneUser,
    String? providerName,
    String? description,
    String? userName,
    String? updatedAt,
    double? rating,
  }) {
    return OrderModel(
      status: status ?? this.status,
      phoneUser: phoneUser ?? this.phoneUser,
      providerName: providerName ?? this.providerName,
      description: description ?? this.description,
      userName: userName ?? this.userName,
      updatedAt: updatedAt ?? this.updatedAt,
      rating: rating ?? this.rating,
    );
  }
}
