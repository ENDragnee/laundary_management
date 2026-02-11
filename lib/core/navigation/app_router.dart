import 'dart:async';
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
import 'package:laundary_management/features/splash/presentation/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppAuthNotifier extends ChangeNotifier {
  bool _isProfileComplete = false;
  bool _isInitializing = true;

  bool get isProfileComplete => _isProfileComplete;
  bool get isInitializing => _isInitializing;

  AppAuthNotifier(AppDatabase database) {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      
      if (session != null) {
        _isInitializing = true;
        notifyListeners();

        // RUN THE CHECK
        _isProfileComplete = await _checkIfProfileExists(database, session.user.id);
      } else {
        _isProfileComplete = false;
      }
      
      _isInitializing = false; 
      notifyListeners();
    });
  }

  /// Robust check: Local -> Cloud -> Timeout
  Future<bool> _checkIfProfileExists(AppDatabase database, String userId) async {
    try {
      // 1. TRY LOCAL (Wait for PowerSync to fetch)
      // We loop-check the local DB for 3 seconds max
      for (int i = 0; i < 6; i++) {
        final localProfile = await (database.select(database.laundries)
              ..where((t) => t.id.equals(userId)))
            .getSingleOrNull();

        if (localProfile != null && 
            localProfile.name != null && 
            localProfile.name!.isNotEmpty) {
          return true;
        }
        // Wait 500ms before next local check
        await Future.delayed(const Duration(milliseconds: 500));
      }

      // 2. FALLBACK TO CLOUD (Direct Supabase Fetch)
      // If local is still empty (maybe sync is slow), check Supabase directly.
      // This accounts for returning users on new devices.
      final cloudProfile = await Supabase.instance.client
          .from('laundries')
          .select('name')
          .eq('id', userId)
          .maybeSingle();

      if (cloudProfile != null && 
          cloudProfile['name'] != null && 
          cloudProfile['name'].toString().isNotEmpty) {
        return true;
      }
    } catch (e) {
      debugPrint("Profile check error (likely offline): $e");
    }

    // 3. DEFAULT TO FALSE
    // If we reach here, either the profile is truly empty or we are offline with no local data.
    return false;
  }
}

GoRouter createAppRouter(AppAuthNotifier authNotifier) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isSplash = state.matchedLocation == '/';

      // 1. While app is determining profile state, stay on Splash
      if (authNotifier.isInitializing && session != null) {
        return isSplash ? null : '/';
      }

      // 2. Not Logged In
      if (session == null) {
        return isLoggingIn ? null : '/login';
      }

      // 3. Logged In, but Profile Incomplete
      if (!authNotifier.isProfileComplete) {
        // Only stay on Onboarding if they are already there
        return isOnboarding ? null : '/onboarding';
      }

      // 4. Logged In & Profile Complete -> Go to Dashboard
      // If they are on Splash, Login, or Onboarding, move them to Dashboard
      if (isSplash || isLoggingIn || isOnboarding) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
      GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
      GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
      GoRoute(
        path: '/order_form',
        builder: (context, state) {
          final LaundryOrder? order = state.extra as LaundryOrder?;
          return OrderFormScreen(order: order);
        },
      ),
      GoRoute(path: '/settings', builder: (context, state) => const ShopSettingsScreen()),
      GoRoute(path: '/support', builder: (context, state) => const SupportScreen()),
    ],
  );
}
