import 'package:onboard/src/presentation/onboarding_controller.dart';
import 'package:onboard/src/presentation/onboarding_step.dart';

import 'onboarding_storage.dart';

late OnboardingController controller;

@override
void initState() {
  super.initState();

  controller = OnboardingController(
    [
      const OnboardingStep(
        image: 'assets/onboarding/step1.png',
        title: 'Welcome',
        description: 'Discover amazing features',
      ),
      const OnboardingStep(
        image: 'assets/onboarding/step2.png',
        title: 'Stay Organized',
        description: 'Manage your tasks efficiently',
      ),
      const OnboardingStep(
        image: 'assets/onboarding/step3.png',
        title: 'Get Started',
        description: 'Let’s begin your journey',
      ),
    ],
    storage: OnboardingStorage(),
  );
}
