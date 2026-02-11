import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  processing,
  ready_for_pickup, // Renamed to match Supabase exactly
  completed,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.ready_for_pickup:
        return 'Ready for Pickup';
      case OrderStatus.completed:
        return 'Completed';
    }
  }

  // Helper to get color-coded status
  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.ready_for_pickup:
        return Colors.green;
      case OrderStatus.completed:
        return Colors.grey;
    }
  }
}
