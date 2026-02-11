import 'package:flutter/material.dart';
import 'package:laundary_management/core/navigation/app_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authNotifier = context.watch<AppAuthNotifier>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Centered Logo and Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(
                      alpha: 0.2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_laundry_service_rounded,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Laundry Manager',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Smart Bookkeeping for your Shop',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Status Area
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                const SizedBox(height: 24),
                // Dynamic feedback text based on app state
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    authNotifier.isInitializing
                        ? 'Synchronizing Shop Data...'
                        : 'Checking Credentials...',
                    key: ValueKey(authNotifier.isInitializing),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary.withValues(alpha: 0.8),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
