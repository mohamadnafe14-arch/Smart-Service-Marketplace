class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"rate": rate, "count": count};
  }
}
