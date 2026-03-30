import 'package:auth/src/application/controller/auth_controller.dart';
import 'package:auth/src/infrastructure/repository/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auth/auth.dart';
import 'package:flutter_riverpod/legacy.dart';

final authRepositoryProvider = Provider(
  (ref) => FakeAuthRepository(),
);

final sessionStorageProvider = Provider(
  (ref) => InMemorySessionStorage(),
);

final sessionTtlProvider = Provider<Duration>(
  (ref) => const Duration(hours: 1),
);

final authFacadeProvider = Provider(
  (ref) => AuthFacade(
    repository: ref.watch(authRepositoryProvider),
    storage: ref.watch(sessionStorageProvider),
    sessionTtl: ref.watch(sessionTtlProvider),
  ),
);

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    facade: ref.watch(authFacadeProvider),
  ),
);
