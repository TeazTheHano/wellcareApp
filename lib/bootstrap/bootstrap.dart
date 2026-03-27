import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wellcare365/app/theme/app_theme.dart';

import 'package:wellcare365/providers/auth_provider.dart';
import 'package:wellcare365/router/app_router.dart';

class Bootstrap extends ConsumerStatefulWidget {
  const Bootstrap({super.key});

  @override
  ConsumerState<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends ConsumerState<Bootstrap> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(authControllerProvider.notifier).restore();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.light(), // TODO: dark
      themeMode: ThemeMode.system,
    );
  }
}
