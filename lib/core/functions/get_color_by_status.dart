import 'package:flutter/material.dart';

Color getColorByStatus(String status) {
  switch (status) {
    case 'pending':
      return Colors.orange;
    case 'active':
      return Colors.green;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.blue;
  }
}
