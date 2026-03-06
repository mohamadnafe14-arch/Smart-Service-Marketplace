class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});
  factory Rating.fromJson(Map<String, dynamic> json) {
    final rates = json['rate'] as List<dynamic>? ?? [];
    final count = json['count'];
    double average = 0;
    if (rates.isNotEmpty) {
      final sum = rates.fold(0.0, (acc, rate) => acc + (rate as num).toDouble());
      average = sum / rates.length;
    }
    return Rating(
      rate: average,
      count: count,
    );
  }

  Map<String, dynamic> toJson() {
    return {"rate": rate, "count": count};
  }
}
