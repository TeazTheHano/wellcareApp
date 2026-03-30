// Contract for authentication repository

import '../entity/account.dart';
import '../entity/auth_session.dart';
import '../value_object/auth_context.dart';

abstract class AuthRepository {
  Future<Account> authenticate({
    required String email,
    required String password,
  });

  Future<AuthContext> resolveInitialContext({
    required String accountId,
  });

  Future<AuthSession?> getCurrentSession();

  Future<void> saveSession(AuthSession session);

  Future<void> clearSession();
}
