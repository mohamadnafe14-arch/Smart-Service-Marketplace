// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:smart_service_market_place/core/models/pagination_link.dart';
import 'package:smart_service_market_place/features/services/model/models/get_provider.dart';

class ProviderResponseModel {
  final List<GetProvider> providers;
  final List<PaginationLink> pagination;
  ProviderResponseModel({required this.providers, required this.pagination});

  ProviderResponseModel copyWith({
    List<GetProvider>? providers,
    List<PaginationLink>? pagination,
  }) {
    return ProviderResponseModel(
      providers: providers ?? this.providers,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'providers': providers.map((x) => x.toMap()).toList(),
      'pagination': pagination.map((x) => x.toMap()).toList(),
    };
  }

  factory ProviderResponseModel.fromMap(Map<String, dynamic> map) {
    return ProviderResponseModel(
      providers: (map['providers'] as List<dynamic>)
          .map((item) => GetProvider.fromMap(item as Map<String, dynamic>))
          .toList(),
      pagination: (map['pagination'] as List<dynamic>)
          .map((item) => PaginationLink.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderResponseModel.fromJson(String source) =>
      ProviderResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'ProviderResponseModel(providers: $providers, pagination: $pagination)';

  @override
  bool operator ==(covariant ProviderResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.providers, providers) &&
        listEquals(other.pagination, pagination);
  }

  @override
  int get hashCode =>
      Object.hash(Object.hashAll(providers), Object.hashAll(pagination));
}
