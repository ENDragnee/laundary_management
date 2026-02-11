import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundary_management/core/constants/order_status.dart'; // Ensure this is imported
import 'package:laundary_management/core/database/app_database.dart';

class OrderListItem extends StatelessWidget {
  final LaundryOrder order;
  final String userTier;
  final VoidCallback onTap;

  const OrderListItem({
    super.key,
    required this.order,
    required this.userTier,
    required this.onTap,
  });

  bool get _isTrial => userTier.toUpperCase() == 'TRIAL';

  @override
  Widget build(BuildContext context) {
    // If you haven't run build_runner yet, 'order.status' might still show as an int.
    // Once build_runner completes, this line will treat it as a typed OrderStatus.
    final OrderStatus status = order.status;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: _isTrial ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: _isTrial
            ? BorderSide(color: theme.dividerColor.withValues(alpha: 0.1))
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header: Customer Name & Status Badge ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.customerName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _isTrial ? theme.disabledColor : null,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      // Uses the .color extension from order_status.dart
                      color: status.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: status.color.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      // Uses the .displayName extension from order_status.dart
                      status.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: status.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // --- Middle: Unique Code & Due Date ---
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      order.code,
                      style: const TextStyle(
                        fontFamily: 'Monospace',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  if (_isTrial)
                    Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: theme.disabledColor,
                    ),

                  const Spacer(),

                  Icon(Icons.event_note, size: 14, color: theme.hintColor),
                  const SizedBox(width: 4),
                  Text(
                    // Correctly parses the String date from Supabase/Drift
                    DateFormat.MMMd().format(DateTime.parse(order.dueDate)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),

              const Divider(height: 24),

              // --- Footer: Total Price & Navigation Hint ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.totalPrice.toStringAsFixed(2)} ETB',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: _isTrial
                          ? theme.disabledColor
                          : theme.primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      if (_isTrial)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            'Read Only',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ),
                      Icon(
                        _isTrial
                            ? Icons.visibility_outlined
                            : Icons.chevron_right,
                        color: theme.hintColor,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
