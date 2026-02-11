import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/constants/order_status.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/order_list_item.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/page_navigator.dart';
import 'package:laundary_management/features/dashboard/presentation/widgets/user_profile_drawer.dart';
import 'package:powersync/powersync.dart' as ps;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final database = context.read<AppDatabase>();
    final controller = context.watch<DashboardController>();
    final powersync = context.read<ps.PowerSyncDatabase>();
    final user = Supabase.instance.client.auth.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const UserProfileDrawer(),
      appBar: AppBar(
        title: const Text('Laundry Manager'),
        elevation: 0,
        actions: [
          // Real-time Sync Indicator
          StreamBuilder<ps.SyncStatus>(
            stream: powersync.statusStream,
            builder: (context, snapshot) {
              final status = snapshot.data;
              Color statusColor = Colors.grey;
              String statusLabel = 'Offline';

              if (status != null && status.connected) {
                if (status.uploading || status.downloading) {
                  statusColor = Colors.orange;
                  statusLabel = 'Syncing';
                } else {
                  statusColor = Colors.green;
                  statusLabel = 'Online';
                }
              }

              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          if (statusLabel == 'Syncing')
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.4),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      statusLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              controller.isDescending
                  ? Icons.sort_by_alpha
                  : Icons.filter_list_alt,
            ),
            onPressed: () => controller.toggleSort(),
            tooltip: 'Sort Orders',
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: () => themeManager.toggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Modern Filter Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.05),
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  ActionChip(
                    avatar: const Icon(Icons.search, size: 16),
                    label: const Text('Search'),
                    onPressed: () => context.push('/search'),
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                  const SizedBox(width: 12),
                  const VerticalDivider(width: 1),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text('All Orders'),
                    selected: controller.selectedStatus == null,
                    onSelected: (_) => controller.setStatus(null),
                  ),
                  ...OrderStatus.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ChoiceChip(
                        label: Text(status.displayName),
                        selected: controller.selectedStatus == status,
                        onSelected: (_) => controller.setStatus(status),
                        selectedColor: status.color.withValues(alpha: 0.15),
                        checkmarkColor: status.color,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // 2. Orders List Section
          Expanded(
            child: StreamBuilder<Laundry?>(
              stream: database.watchLaundryProfile(user?.id ?? ''),
              builder: (context, profileSnapshot) {
                final tier = profileSnapshot.data?.tier ?? 'TRIAL';

                return StreamBuilder<List<LaundryOrder>>(
                  stream: database.watchOrdersPaged(
                    limit: DashboardController.pageSize,
                    offset: controller.offset,
                    filterStatus: controller.selectedStatus,
                    sortDescending: controller.isDescending,
                  ),
                  builder: (context, snapshot) {
                    final orders = snapshot.data ?? [];

                    if (snapshot.connectionState == ConnectionState.waiting &&
                        orders.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (orders.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 48,
                              color: theme.disabledColor,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No matching orders found.',
                              style: TextStyle(color: theme.disabledColor),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return OrderListItem(
                          order: orders[index],
                          userTier: tier,
                          onTap: () =>
                              context.push('/order_form', extra: orders[index]),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      // 3. FIXED: Page Navigator is now in bottomNavigationBar
      // This prevents the FAB from overlapping the pagination UI
      bottomNavigationBar: SafeArea(
        child: StreamBuilder<int>(
          stream: database.watchOrderCount(controller.selectedStatus),
          builder: (context, snapshot) {
            final count = snapshot.data ?? 0;
            return PageNavigator(
              currentPage: controller.currentPage,
              totalCount: count,
              pageSize: DashboardController.pageSize,
              onPageChanged: (page) => controller.setPage(page),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/order_form'),
        label: const Text('New Order'),
        icon: const Icon(Icons.add_rounded),
        elevation: 4,
      ),
    );
  }
}
