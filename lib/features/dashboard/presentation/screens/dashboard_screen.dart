import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/order_list_item.dart';
import 'package:powersync/powersync.dart'; // Import PowerSync for SyncStatus
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final database = context.read<AppDatabase>();
    // Get PowerSync instance from Provider
    final powersync = context.read<PowerSyncDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // --- Sync Status Indicator ---
          StreamBuilder<SyncStatus>(
            stream: powersync.statusStream,
            builder: (context, snapshot) {
              final status = snapshot.data;

              // Define Status UI properties
              Color color = Colors.grey;
              String label = 'Initializing';

              if (status != null) {
                if (!status.connected) {
                  color = Colors.red;
                  label = 'Offline';
                } else if (status.uploading || status.downloading) {
                  color = Colors.orange;
                  label = 'Syncing';
                } else if (status.connected) {
                  color = Colors.green;
                  label = 'Online';
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // The Bubble/Dot
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (label ==
                              'Syncing') // Optional glow effect when syncing
                            BoxShadow(
                              color: color.withValues(),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    // The Text
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // -----------------------------
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
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderListItem(
                order: order,
                onTap: () => context.push('/order_form', extra: order),
                onEdit: () => context.push('/order_form', extra: order),
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
