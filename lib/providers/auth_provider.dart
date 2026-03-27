import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/src/domain/entity/account.dart';
import '../../features/auth/src/domain/entity/auth_session.dart';
import '../../features/auth/src/domain/repository/auth_repository.dart';
import '../../features/auth/src/domain/value_object/auth_context.dart';

import '../../features/auth/src/infrastructure/storage/secure_session_storage.dart';
import '../../features/auth/src/infrastructure/repository/fake_auth_repository.dart';

/// ============================================================
/// Session Storage Abstraction
/// ============================================================

abstract class SessionStorage {
  Future<void> save(AuthSession session);
  Future<AuthSession?> load();
  Future<void> clear();
}

/// ============================================================
/// Auth State
/// ============================================================

class AuthState {
  final bool isLoading;
  final String? error;
  final AuthSession? session;

  const AuthState({required this.isLoading, required this.session, this.error});

  factory AuthState.initial() {
    return const AuthState(isLoading: false, session: null, error: null);
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthSession? session,
    bool clearSession = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      session: clearSession ? null : (session ?? this.session),
    );
  }
}

/// ============================================================
/// Auth Facade
/// ============================================================

class AuthFacade {
  final AuthRepository repository;
  final SessionStorage storage;
  final Duration sessionTtl;

  AuthFacade({
    required this.repository,
    required this.storage,
    required this.sessionTtl,
  });

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final Account account = await repository.authenticate(
      email: email,
      password: password,
    );

    final AuthContext context = await repository.resolveInitialContext(
      accountId: account.accountId,
    );

    final now = DateTime.now();

    final session = AuthSession(
      accountId: account.accountId,
      context: context,
      issuedAt: now,
      expiresAt: now.add(sessionTtl),
    );

    await storage.save(session);

    return session;
  }

  Future<AuthSession?> restore() async {
    final session = await storage.load();

    if (session == null) return null;

    if (session.isExpired) {
      await storage.clear();
      return null;
    }

    return session;
  }

  Future<void> logout() async {
    await storage.clear();
  }
}

/// ============================================================
/// Auth Controller (Presentation Orchestrator)
/// ============================================================

class AuthController extends StateNotifier<AuthState> {
  final AuthFacade facade;

  AuthController(this.facade) : super(AuthState.initial());

  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final session = await facade.login(email: email, password: password);

      state = state.copyWith(isLoading: false, session: session);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> restore() async {
    final session = await facade.restore();

    if (session == null) {
      state = state.copyWith(clearSession: true);
    } else {
      state = state.copyWith(session: session);
    }
  }

  Future<void> logout() async {
    await facade.logout();
    state = state.copyWith(clearSession: true);
  }
}

/// ============================================================
/// Providers Wiring
/// ============================================================

/// Repository (override khi có BE thật)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FakeAuthRepository();
});

/// Session storage (override khi dùng secure storage)
final sessionStorageProvider = Provider<SessionStorage>((ref) {
  return SecureSessionStorage(const FlutterSecureStorage());
});

/// TTL config
final sessionTtlProvider = Provider<Duration>((ref) {
  return Duration(hours: 12);
});

/// Facade
final authFacadeProvider = Provider<AuthFacade>((ref) {
  return AuthFacade(
    repository: ref.read(authRepositoryProvider),
    storage: ref.read(sessionStorageProvider),
    sessionTtl: ref.read(sessionTtlProvider),
  );
});

/// Controller
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref.read(authFacadeProvider));
  },
);
