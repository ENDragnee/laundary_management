import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:laundary_management/core/constants/order_status.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final database = context.read<AppDatabase>();

    Color getStatusColor(OrderStatus status) {
      switch (status) {
        case OrderStatus.pending:
          return Colors.orange;
        case OrderStatus.processing:
          return Colors.blue;
        case OrderStatus.readyForPickup:
          return Colors.green;
        case OrderStatus.completed:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () => themeManager.toggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: StreamBuilder<List<LaundryOrder>>(
        stream: database.watchAllOrders(),
        builder: (context, snapshot) {
          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(child: Text('No laundry orders yet.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final status = OrderStatus.values[order.status];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(
                    order.customerName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Updated Subtitle to show Code and Date
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'Code: ${order.code}',
                        style: TextStyle(
                          fontFamily: 'Monospace',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text('Due: ${DateFormat.yMMMd().format(order.dueDate)}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status.displayName,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Updated Currency to ETB
                      Text(
                        '${order.totalPrice.toStringAsFixed(2)} ETB',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () => context.push('/order_form', extra: order),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/order_form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
