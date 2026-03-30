import '../../domain/entity/auth_session.dart';
import '../../domain/repository/session_repository.dart';

class InMemorySessionStorage implements SessionStorage {
  AuthSession? _session;

  @override
  Future<void> save(AuthSession session) async {
    _session = session;
  }

  @override
  Future<AuthSession?> load() async {
    return _session;
  }

  @override
  Future<void> clear() async {
    _session = null;
  }
}

// class SecureSessionStorage implements SessionStorage {
//   final FlutterSecureStorage _storage;

//   SecureSessionStorage(this._storage);

//   @override
//   Future<void> save(AuthSession session) async {
//     await _storage.write(
//       key: 'auth_session',
//       value: jsonEncode(_serialize(session)),
//     );
//   }

//   ...
// }
