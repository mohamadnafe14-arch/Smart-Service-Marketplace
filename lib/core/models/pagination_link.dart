// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaginationLink {
  final String? url;
  final String label;
  final bool active;
  PaginationLink({
    this.url,
    required this.label,
    required this.active,
  });

  PaginationLink copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return PaginationLink(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'label': label,
      'active': active,
    };
  }

  factory PaginationLink.fromMap(Map<String, dynamic> map) {
    return PaginationLink(
      url: map['url'] != null ? map['url'] as String : null,
      label: map['label'] as String,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationLink.fromJson(String source) => PaginationLink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaginationLink(url: $url, label: $label, active: $active)';

  @override
  bool operator ==(covariant PaginationLink other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url &&
      other.label == label &&
      other.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}
