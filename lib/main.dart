import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bootstrap/bootstrap.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Bootstrap(),
    ),
  );
}