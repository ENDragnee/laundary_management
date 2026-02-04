import 'package:flutter/material.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We use .read here because we are calling a function, not rebuilding the widget
    final themeManager = context.read<ThemeManager>();
    // We use Theme.of(context) to find out the current effective brightness
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () {
              // Toggle the theme
              themeManager.toggleTheme(!isDarkMode);
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Laundry Orders Will Appear Here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create new order screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}