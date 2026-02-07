import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              themeManager.toggleTheme(!isDarkMode);
            },
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
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(order.customerName),
                  subtitle: Text(
                    'Due: ${DateFormat.yMMMd().format(order.dueDate)}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Code: ${order.code}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text('\$ETB{order.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                  onTap: () {
                    // Navigate to edit screen, passing the order object
                    context.push('/order_form', extra: order);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new order screen
          context.push('/order_form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

