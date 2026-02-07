import 'package:go_router/go_router.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:laundary_management/features/laundry_order/presentation/screens/order_form_screen.dart';
import 'package:laundary_management/features/splash/presentation/screens/splash_screen.dart';
import 'package:laundary_management/features/search/presentation/screens/search_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/order_form',
      builder: (context, state) {
        // The 'extra' property holds the object we pass during navigation
        final LaundryOrder? order = state.extra as LaundryOrder?;
        return OrderFormScreen(order: order);
      },
    ),
    GoRoute(
      path: '/search', // New Route
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);
