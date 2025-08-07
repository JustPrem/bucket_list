// ---- Imports ----

// Base.
import 'package:flutter/material.dart';

// Data Models.
import 'package:bucket_list/data_models/settings.dart';

// Provider.
import 'package:bucket_list/providers/settings_provider.dart';

// Routes.
import 'package:bucket_list/routes/route_home.dart';

// External.
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ---- Main ----
void main()
{
  // Setup packegs.
  WidgetsFlutterBinding.ensureInitialized();

  // Start the app.
  runApp(const ProviderScope(child: MainApp()));
}

// ---- Material App ----
class MainApp extends ConsumerWidget
{
  // Constructor.
  const MainApp({super.key});

  // Build Method.
  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    // Load the settings.
    ref.read(settingsStateProvider.notifier).loadSettings();

    // Get settings.
    Settings settings = ref.watch(settingsStateProvider);

    // Watch the provider.
    return MaterialApp
    (
      // Debug Banner go brrrrrr.
      debugShowCheckedModeBanner: false,

      // Theme.
      theme:      ThemeData.light(useMaterial3: true),
      darkTheme:  ThemeData.dark(useMaterial3: true),
      themeMode:  (settings.darkMode)? ThemeMode.dark : ThemeMode.light,

      // Routes.
      routes:
      {
        "/" : (context) => const RouteHome(),
      },

      initialRoute: "/",
    );
  }
}
