import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// String isSaved = "isSaved";

class SharedPreferenceApp extends GetxController {
  static SharedPreferences? prefs;
  @override
  void onInit() async {
    super.onInit();
    handleSetPrefs();
  }

  @override
  void dispose() {
    super.dispose();
    prefs = null;
  }

  static Future<void> handleSetPrefs() async {
    if (prefs != null) return;

    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> handleSetString(String key, String value) async {
    await handleSetPrefs();
    await prefs!.setString(key, value);
  }

  static Future<void> handleSetInt(String key, int value) async {
    await handleSetPrefs();
    await prefs!.setInt(key, value);
  }

  static Future<void> handleSetBool(String key, bool value) async {
    await handleSetPrefs();
    await prefs!.setBool(key, value);
  }

  static Future<void> handleSetDouble(String key, double value) async {
    await handleSetPrefs();
    await prefs!.setDouble(key, value);
  }

  static Future<void> handleSetListString(
    String key,
    List<String> value,
  ) async {
    await handleSetPrefs();
    await prefs!.setStringList(key, value);
  }

  static String? handleGetString(String key) {
    handleSetPrefs();
    return prefs!.getString(key);
  }

  static int? handleGetInt(String key) {
    handleSetPrefs();
    return prefs!.getInt(key);
  }

  static bool? handleGetBool(String key) {
    handleSetPrefs();
    return prefs?.getBool(key);
  }

  static double? handleGetDouble(String key) {
    handleSetPrefs();
    return prefs!.getDouble(key);
  }

  static List<String>? handleGetStringList(String key) {
    handleSetPrefs();
    return prefs!.getStringList(key);
  }

  static Future<void> handleRemove(String key) async {
    await handleSetPrefs();
    await prefs!.remove(key);
  }
}
