import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laundary_management/core/database/app_database.dart';
import 'package:laundary_management/core/database/powersync_connector.dart';
import 'package:laundary_management/core/database/powersync_schema.dart';
import 'package:laundary_management/core/navigation/app_router.dart';
import 'package:laundary_management/core/theme/rose_pine_theme.dart';
import 'package:laundary_management/core/theme/theme_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powersync/powersync.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // 1. Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  // 2. Initialize PowerSync
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, 'laundry_sync.db');

  final powerSyncDb = PowerSyncDatabase(schema: schema, path: dbPath);
  await powerSyncDb.initialize();

  // 3. Connect PowerSync
  final connector = SupabaseConnector();
  powerSyncDb.connect(connector: connector);

  // 4. Initialize Drift
  final database = AppDatabase(powerSyncDb);

  // 5. Initialize Auth Notifier (for Router)
  final authNotifier = AppAuthNotifier(database);

  // 6. Theme
  final themeManager = ThemeManager();
  await themeManager.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<PowerSyncDatabase>.value(value: powerSyncDb),
        ChangeNotifierProvider.value(value: themeManager),
        // Provide the Auth Notifier to the widget tree
        ChangeNotifierProvider.value(value: authNotifier),
      ],
      // Pass the notifier to MyApp so it can create the router
      child: MyApp(authNotifier: authNotifier),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Now accepts the notifier instead of the database
  final AppAuthNotifier authNotifier;

  const MyApp({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    // Create the router using the notifier
    final router = createAppRouter(authNotifier);

    return MaterialApp.router(
      title: 'Laundry Manager',
      debugShowCheckedModeBanner: false,
      theme: RosePineTheme.lightTheme,
      darkTheme: RosePineTheme.darkTheme,
      themeMode: themeManager.themeMode,
      routerConfig: router,
    );
  }
}
