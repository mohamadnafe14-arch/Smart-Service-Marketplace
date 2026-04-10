import 'package:flutter/scheduler.dart';

class MakeOrderParam {
  final String providerId;
  final String token;
  final String phone;
  final VoidCallback pop;
  const MakeOrderParam({
    required this.providerId,
    required this.token,
    required this.phone,
    required this.pop,
  });
}
