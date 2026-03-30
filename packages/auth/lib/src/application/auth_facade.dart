import '../domain/entity/auth_session.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/session_repository.dart';

class AuthConfig {
  final Duration sessionTtl;
  final SessionStorage storage;

  const AuthConfig({required this.sessionTtl, required this.storage});
}

class AuthFacade {
  final AuthRepository repository;
  final SessionStorage storage;
  final Duration sessionTtl;

  AuthFacade({
    required this.repository,
    required this.storage,
    required this.sessionTtl,
  });

  Future<AuthSession> login(String email, String password) async {
    final account = await repository.authenticate(
      email: email,
      password: password,
    );

    final context = await repository.resolveInitialContext(
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
