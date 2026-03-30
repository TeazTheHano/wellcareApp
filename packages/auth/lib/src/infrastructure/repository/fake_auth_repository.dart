import '../../domain/entity/account.dart';
import '../../domain/entity/auth_session.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/value_object/auth_context.dart';

class FakeAuthRepository implements AuthRepository {
  AuthSession? _session;
  String? _lastEmail;

  /// Fake database
  final Map<String, _FakeAccount> _accounts = {
    'system@dev.com': _FakeAccount(
      id: 'acc-system-1',
      password: '123456',
      context: AuthContext.system(),
    ),
    'tenant@dev.com': _FakeAccount(
      id: 'acc-tenant-1',
      password: '123456',
      context: AuthContext.tenant(tenantId: 'tenant-dev-1'),
    ),
    'user@dev.com': _FakeAccount(
      id: 'acc-user-1',
      password: '123456',
      context: AuthContext.project(
        tenantId: 'tenant-dev-1',
        projectId: 'project-dev-1',
      ),
    ),
  };

  @override
  Future<Account> authenticate({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final account = _accounts[email];

    if (account == null) {
      throw Exception('Account not found');
    }

    if (account.password != password) {
      throw Exception('Invalid password');
    }

    _lastEmail = email;

    return Account(accountId: account.id, email: email);
  }

  @override
  Future<AuthContext> resolveInitialContext({required String accountId}) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final email = _lastEmail;

    if (email == null || !_accounts.containsKey(email)) {
      throw Exception('Context resolution failed');
    }

    return _accounts[email]!.context;
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    return _session;
  }

  @override
  Future<void> saveSession(AuthSession session) async {
    _session = session;
  }

  @override
  Future<void> clearSession() async {
    _session = null;
  }
}

/// Internal fake model (không leak ra domain)
class _FakeAccount {
  final String id;
  final String password;
  final AuthContext context;

  const _FakeAccount({
    required this.id,
    required this.password,
    required this.context,
  });
}
