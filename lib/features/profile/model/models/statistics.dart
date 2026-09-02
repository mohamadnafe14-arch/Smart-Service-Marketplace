// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Statistics {
  final int totalNumberOfOrders;
  final int finishedOrders;
  Statistics({required this.totalNumberOfOrders, required this.finishedOrders, });

  Statistics copyWith({int? totalNumberOfOrders, int? finishedOrders}) {
    return Statistics(
      totalNumberOfOrders: totalNumberOfOrders ?? this.totalNumberOfOrders,
      finishedOrders: finishedOrders ?? this.finishedOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalNumberOfOrders': totalNumberOfOrders,
      'finishedOrders': finishedOrders,
    };
  }

  factory Statistics.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return Statistics(totalNumberOfOrders: 0, finishedOrders: 0);
    }
    return Statistics(
      totalNumberOfOrders: map['totalNumberOfOrders'] ?? 0,
      finishedOrders: map['finishedOrders'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Statistics.fromJson(String source) =>
      Statistics.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Statistics(totalNumberOfOrders: $totalNumberOfOrders, finishedOrders: $finishedOrders)';

  @override
  bool operator ==(covariant Statistics other) {
    if (identical(this, other)) return true;

    return other.totalNumberOfOrders == totalNumberOfOrders &&
        other.finishedOrders == finishedOrders;
  }

  @override
  int get hashCode => totalNumberOfOrders.hashCode ^ finishedOrders.hashCode;
}
