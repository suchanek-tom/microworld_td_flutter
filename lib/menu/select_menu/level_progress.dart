import 'package:shared_preferences/shared_preferences.dart';

class LevelProgress {
  static const String _key = "unlocked_levels";

  static Future<int> getUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 1;
  }

  static Future<void> setUnlockedLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_key) ?? 1;
    if (level > current) {
      await prefs.setInt(_key, level);
    }
  }

  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
