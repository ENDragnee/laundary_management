import 'package:go_router/go_router.dart';
import 'package:laundary_management/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:laundary_management/features/splash/presentation/screens/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);