import 'package:auth/auth.dart';

class InMemorySessionStorage implements SessionStorage {
  AuthSession? _session;

  @override
  Future<void> save(AuthSession session) async {
    _session = session;
  }

  @override
  Future<AuthSession?> load() async => _session;

  @override
  Future<void> clear() async {
    _session = null;
  }
}