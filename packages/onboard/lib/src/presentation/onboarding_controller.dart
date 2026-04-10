import 'package:flutter/foundation.dart';
import 'package:onboard/src/presentation/onboarding_step.dart';

import 'onboarding_storage.dart';

class OnboardingController extends ChangeNotifier {
  final List<OnboardingStep> steps;
  final OnboardingStorage storage;

  int _currentIndex = 0;

  OnboardingController(
    this.steps, {
    required this.storage,
  });

  int get currentIndex => _currentIndex;
  OnboardingStep get currentStep => steps[_currentIndex];
  bool get isLast => _currentIndex == steps.length - 1;

  void next() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void skip() {
    _currentIndex = steps.length - 1;
    notifyListeners();
  }

  Future<void> complete(VoidCallback onCompleted) async {
    await storage.markCompleted();
    onCompleted();
  }
}
