import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/order_list_item.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/user_profile_drawer.dart'; // Import
import 'package:powersync/powersync.dart' as ps;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final database = context.read<AppDatabase>();
    final powersync = context.read<ps.PowerSyncDatabase>();
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      drawer: const UserProfileDrawer(), // Redesigned Widget
      appBar: AppBar(
        title: const Text('Laundry Manager'),
        centerTitle: false,
        actions: [
          // Sync Status Indicator
          StreamBuilder<ps.SyncStatus>(
            stream: powersync.statusStream,
            builder: (context, snapshot) {
              final status = snapshot.data;
              Color color = Colors.grey;
              String label = 'Offline';

              if (status != null && status.connected) {
                if (status.uploading || status.downloading) {
                  color = Colors.orange;
                  label = 'Syncing';
                } else {
                  color = Colors.green;
                  label = 'Online';
                }
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (label == 'Syncing')
                            BoxShadow(
                              color: color.withValues(alpha: 0.5),
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
      body: StreamBuilder<Laundry?>(
        stream: (database.select(
          database.laundries,
        )..where((t) => t.id.equals(user?.id ?? ''))).watchSingleOrNull(),
        builder: (context, profileSnapshot) {
          final tier = profileSnapshot.data?.tier ?? 'TRIAL';

          return StreamBuilder<List<LaundryOrder>>(
            stream: database.watchAllOrders(),
            builder: (context, snapshot) {
              final orders = snapshot.data ?? [];

              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_laundry_service_outlined,
                        size: 64,
                        color: Theme.of(context).disabledColor,
                      ),
                      const SizedBox(height: 16),
                      const Text('No laundry orders yet.'),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80, top: 8),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderListItem(
                    order: order,
                    userTier: tier,
                    onTap: () => context.push('/order_form', extra: order),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/order_form'),
        label: const Text('New Order'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
