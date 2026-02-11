import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/features/auth/presentation/screens/login_screen.dart';
import 'package:laundary_management/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:laundary_management/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:laundary_management/features/laundry_order/presentation/screens/order_form_screen.dart';
import 'package:laundary_management/features/search/presentation/screens/search_screen.dart';
import 'package:laundary_management/features/profile/presentation/screens/shop_settings_screen.dart';
import 'package:laundary_management/features/profile/presentation/screens/support_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// This notifier now holds the state, preventing redundant checks
class AppAuthNotifier extends ChangeNotifier {
  bool _isProfileComplete = false;
  bool get isProfileComplete => _isProfileComplete;

  AppAuthNotifier(AppDatabase database) {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null) {
        // When the user logs in, check their profile status from the local DB.
        // There might be a slight delay as PowerSync downloads the profile for the first time.
        // A short delay here is acceptable to ensure we have the data.
        await Future.delayed(const Duration(milliseconds: 500));

        final userProfile = await (database.select(
          database.laundries,
        )..where((t) => t.id.equals(session.user.id))).getSingleOrNull();

        // Update the state based on whether the name is filled out
        _isProfileComplete =
            userProfile != null &&
            userProfile.name != null &&
            userProfile.name!.isNotEmpty;
      } else {
        // If logged out, reset the profile status
        _isProfileComplete = false;
      }
      // Notify GoRouter that the auth state has changed and it needs to re-evaluate the redirect.
      notifyListeners();
    });
  }
}

GoRouter createAppRouter(AppAuthNotifier authNotifier) {
  return GoRouter(
    initialLocation: '/dashboard',
    // The router now listens to our custom notifier
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';

      // 1. User is not logged in.
      if (session == null) {
        // If they are on the login page, let them stay. Otherwise, redirect to login.
        return isLoggingIn ? null : '/login';
      }

      // 2. User is logged in, but their profile is incomplete.
      if (!authNotifier.isProfileComplete) {
        // If they are on the onboarding page, let them stay. Otherwise, redirect to onboarding.
        return isOnboarding ? null : '/onboarding';
      }

      // 3. User is logged in AND their profile is complete.
      if (isLoggingIn || isOnboarding) {
        // If they are on the login or onboarding pages, send them to the dashboard.
        return '/dashboard';
      }

      // Otherwise, no redirect is needed.
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/order_form',
        builder: (context, state) {
          final LaundryOrder? order = state.extra as LaundryOrder?;
          return OrderFormScreen(order: order);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const ShopSettingsScreen(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
    ],
  );
}
