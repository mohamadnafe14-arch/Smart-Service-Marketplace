class Statistics {
  final int totalNumberOfOrders;
  final int finishedOrders;
  Statistics({required this.totalNumberOfOrders, required this.finishedOrders});
  factory Statistics.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Statistics(totalNumberOfOrders: 0, finishedOrders: 0);
    }
    return Statistics(
      totalNumberOfOrders: json['totalNumberOfOrders'] ?? 0,
      finishedOrders: json['finishedOrders'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        'totalNumberOfOrders': totalNumberOfOrders,
        'finishedOrders': finishedOrders,
      };
}
