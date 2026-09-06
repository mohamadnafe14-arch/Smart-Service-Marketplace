// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MakeOrderParam {
  final String providerId;
  final String token;
  final String phone;
  final VoidCallback pop;
  MakeOrderParam({
    required this.providerId,
    required this.token,
    required this.phone,
    required this.pop,
  });

  MakeOrderParam copyWith({
    String? providerId,
    String? token,
    String? phone,
    VoidCallback? pop,
  }) {
    return MakeOrderParam(
      providerId: providerId ?? this.providerId,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      pop: pop ?? this.pop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'providerId': providerId,
      'token': token,
      'phone': phone,
    };
  }

  factory MakeOrderParam.fromMap(Map<String, dynamic> map) {
    return MakeOrderParam(
      providerId: map['providerId'] as String,
      token: map['token'] as String,
      phone: map['phone'] as String,
      pop: () {},
    );
  }

  String toJson() => json.encode(toMap());

  factory MakeOrderParam.fromJson(String source) => MakeOrderParam.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MakeOrderParam(providerId: $providerId, token: $token, phone: $phone)';

  @override
  bool operator ==(covariant MakeOrderParam other) {
    if (identical(this, other)) return true;
  
    return 
      other.providerId == providerId &&
      other.token == token &&
      other.phone == phone;
  }

  @override
  int get hashCode => providerId.hashCode ^ token.hashCode ^ phone.hashCode;
}
