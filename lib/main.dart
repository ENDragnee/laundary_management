import 'package:flutter/material.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/navigation/app_router.dart';
import 'package:laundary_management/core/theme/rose_pine_theme.dart';
import 'package:laundary_management/core/theme/theme_manager.dart'; // <-- Import
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      // <-- Change to MultiProvider
      providers: [
        Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider(
          // <-- Add ThemeManager
          create: (context) => ThemeManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the ThemeManager for changes
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp.router(
      title: 'Laundry Manager',
      debugShowCheckedModeBanner: false,
      // Themes
      theme: RosePineTheme.lightTheme,
      darkTheme: RosePineTheme.darkTheme,
      themeMode: themeManager.themeMode, // <-- Use the value from the manager
      // Router
      routerConfig: appRouter,
    );
  }
}
