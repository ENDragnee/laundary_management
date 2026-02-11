import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/order_list_item.dart';
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

    return Scaffold(
      drawer: const UserProfileDrawer(),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Sync Status Indicator
          StreamBuilder<ps.SyncStatus>(
            stream: powersync.statusStream,
            builder: (context, snapshot) {
              final status = snapshot.data;
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

class UserProfileDrawer extends StatelessWidget {
  const UserProfileDrawer({super.key});

  Future<void> _logout(BuildContext context) async {
    final router = GoRouter.of(context);
    final powersync = Provider.of<ps.PowerSyncDatabase>(context, listen: false);

    await powersync.disconnect();
    await Supabase.instance.client.auth.signOut();
    router.go('/login');
  }

  Color _getTierColor(String tier) {
    switch (tier.toUpperCase()) {
      case 'PREMIUM':
        return Colors.purple;
      case 'REGULAR':
        return Colors.blue;
      case 'TRIAL':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No Email';
    final database = context.read<AppDatabase>();

    return Drawer(
      child: Column(
        children: [
          // This header reactively listens for changes to the user's profile
          StreamBuilder<Laundry?>(
            stream: (database.select(
              database.laundries,
            )..where((t) => t.id.equals(user?.id ?? ''))).watchSingleOrNull(),
            builder: (context, snapshot) {
              final laundry = snapshot.data;
              final tier = laundry?.tier ?? 'TRIAL';
              final name = laundry?.name ?? 'Laundry Shop';

              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'L',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  ),
                ),
                accountName: Text(
                  name,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Row(
                  children: [
                    Text(
                      '$email   ●   ',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getTierColor(tier),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tier,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Profile Settings'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to the onboarding screen to allow editing
              context.push('/onboarding');
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: theme.colorScheme.error),
            title: Text(
              'Logout',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () => _logout(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
