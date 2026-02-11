import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:powersync/powersync.dart' as ps;
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileDrawer extends StatelessWidget {
  const UserProfileDrawer({super.key});

  Future<void> _logout(BuildContext context) async {
    final router = GoRouter.of(context);
    final powersync = Provider.of<ps.PowerSyncDatabase>(context, listen: false);

    // Show loading or close drawer
    Navigator.pop(context);

    await powersync.disconnect();
    await Supabase.instance.client.auth.signOut();
    router.go('/login');
  }

  Color _getTierColor(String tier) {
    switch (tier.toUpperCase()) {
      case 'PREMIUM':
        return const Color(0xFFC4A7E7); // Iris (Rose Pine)
      case 'REGULAR':
        return const Color(0xFF9CCFD8); // Foam (Rose Pine)
      default:
        return const Color(0xFFEBBCBA); // Rose (Rose Pine)
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? 'No Email';
    final database = context.read<AppDatabase>();

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          // Custom Header Section
          StreamBuilder<Laundry?>(
            stream: (database.select(
              database.laundries,
            )..where((t) => t.id.equals(user?.id ?? ''))).watchSingleOrNull(),
            builder: (context, snapshot) {
              final laundry = snapshot.data;
              final tier = laundry?.tier ?? 'TRIAL';
              final name = laundry?.name ?? 'Laundry Shop';

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 24,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : 'L',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getTierColor(tier),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$tier PLAN',
                        style: const TextStyle(
                          color: Color(
                            0xFF191724,
                          ), // Base background for contrast
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDrawerItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  onTap: () => Navigator.pop(context),
                  theme: theme,
                ),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  label: 'Shop Settings',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/onboarding');
                  },
                  theme: theme,
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline_rounded,
                  label: 'Support',
                  onTap: () {},
                  theme: theme,
                ),
              ],
            ),
          ),

          // Logout Section
          const Divider(indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildDrawerItem(
              icon: Icons.logout_rounded,
              label: 'Sign Out',
              onTap: () => _logout(context),
              theme: theme,
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
    Color? color,
  }) {
    final itemColor = color ?? theme.colorScheme.onSurface;
    return ListTile(
      leading: Icon(icon, color: itemColor.withValues(alpha: 0.7)),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: itemColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
