import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureConfig {
  final bool auth;
  final bool dashboard;
  final bool report;
  final bool devMode;

  const FeatureConfig({
    required this.auth,
    required this.dashboard,
    required this.report,
    required this.devMode,
  });
}

final featureConfigProvider = Provider<FeatureConfig>(
  (_) => const FeatureConfig(
    devMode: false,
    auth: true,
    dashboard: true,
    report: false,
  ),
);
