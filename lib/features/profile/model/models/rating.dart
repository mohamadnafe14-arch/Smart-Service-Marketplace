// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  final double rate;
  final int count;
  Rating({required this.rate, required this.count});

  Rating copyWith({double? rate, int? count}) {
    return Rating(rate: rate ?? this.rate, count: count ?? this.count);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'rate': rate, 'count': count};
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) return Rating(rate: 0.0, count: 0);
    return Rating(
      rate: (map['rate'] as num?)?.toDouble() ?? 0.0,
      count: map['count'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';

  @override
  bool operator ==(covariant Rating other) {
    if (identical(this, other)) return true;

    return other.rate == rate && other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
