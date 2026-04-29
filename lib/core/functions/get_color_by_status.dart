import 'package:flutter/material.dart';

Color getColorByStatus(String status) {
  switch (status) {
    case 'pending':
      return Colors.orange;
    case 'accepted':
      return Colors.green;
    case 'cancelledww':
      return Colors.red;
    default:
      return Colors.blue;
  }
}
