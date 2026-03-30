import '../entity/auth_session.dart';

abstract class SessionStorage {
  Future<void> save(AuthSession session);
  Future<AuthSession?> load();
  Future<void> clear();
}
