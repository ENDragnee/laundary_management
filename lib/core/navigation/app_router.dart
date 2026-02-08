import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/features/auth/presentation/screens/login_screen.dart';
import 'package:laundary_management/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:laundary_management/features/laundry_order/presentation/screens/order_form_screen.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/features/search/presentation/screens/search_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Helper class to notify GoRouter when Auth state changes
class AppRouterRefreshStream extends ChangeNotifier {
  AppRouterRefreshStream() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      notifyListeners();
    });
  }
}

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  // Forces the router to re-evaluate the redirect logic whenever auth state changes
  refreshListenable: AppRouterRefreshStream(),
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isLoggingIn = state.matchedLocation == '/login';

    // If not logged in and not on login screen -> go to login
    if (session == null && !isLoggingIn) return '/login';

    // If logged in and on login screen -> go to dashboard
    if (session != null && isLoggingIn) return '/dashboard';

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    GoRoute(
      path: '/order_form',
      builder: (context, state) {
        final LaundryOrder? order = state.extra as LaundryOrder?;
        return OrderFormScreen(order: order);
      },
    ),
  ],
);
