import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onDone;

  const OnboardingButton({
    super.key,
    required this.isLast,
    required this.onNext,
    required this.onSkip,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (!isLast)
              TextButton(
                onPressed: onSkip,
                child: const Text("Skip"),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: isLast ? onDone : onNext,
              child: Text(isLast ? "Start" : "Next"),
            ),
          ],
        ),
      ),
    );
  }
}
