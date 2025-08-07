// ---- Imports ----

// Custom
import 'package:bucket_list/data_models/settings.dart';

// External
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Add the generated file.
part 'settings_provider.g.dart';

/// ---- SettingsState provider ----
@riverpod
class SettingsState extends _$SettingsState
{
  // Provider build - like a constructor for providers.
  @override
  Settings build()
  {
    return Settings();
  }
  
  /// Load the users settings.
  Future<void> loadSettings() async
  {
    // Load the shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Set the settings.
    state = Settings
    (
      darkMode: (prefs.getBool('darkMode') ?? false),
    );
  }

  /// Change settings, dark mode.
  Future<void> toggleDarkMode() async
  {
    // Load the shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Set the settings.
    state = Settings
    (
      darkMode: !state.darkMode,
    );

    // Set the prefs.
    await prefs.setBool('darkMode', state.darkMode);
  }
}

