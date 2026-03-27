import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  danger,
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonVariant variant;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;

    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(label),
    );
  }
}