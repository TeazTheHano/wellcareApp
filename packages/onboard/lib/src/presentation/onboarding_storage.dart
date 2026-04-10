import 'package:shared_preferences/shared_preferences.dart';

/// EN: Handles onboarding UX state persistence
/// VI: Quản lý trạng thái onboarding (UX state)
class OnboardingStorage {
  static const _versionKey = 'onboarding_version';

  /// 🔥 Change this when onboarding content changes
  static const _currentVersion = 1;

  /// EN: Check if onboarding should be shown
  /// VI: Kiểm tra có cần hiển thị onboarding không
  Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    final savedVersion = prefs.getInt(_versionKey) ?? 0;

    return savedVersion < _currentVersion;
  }

  /// EN: Mark onboarding as completed
  /// VI: Đánh dấu đã hoàn thành onboarding
  Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_versionKey, _currentVersion);
  }

  /// EN: Reset onboarding (for debug / settings)
  /// VI: Reset onboarding (dùng cho debug hoặc settings)
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_versionKey);
  }
}