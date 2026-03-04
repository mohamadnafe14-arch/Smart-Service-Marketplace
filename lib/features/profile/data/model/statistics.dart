class Statistics {
  final int totalNumberOfOrders;
  final int finishedOrders;
  Statistics({required this.totalNumberOfOrders, required this.finishedOrders});
  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      totalNumberOfOrders: json['totalNumberOfOrders'] as int,
      finishedOrders: json['finishedOrders'] as int,
    );
  }
}
