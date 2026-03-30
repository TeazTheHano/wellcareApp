import 'dart:convert';

import 'package:auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureSessionStorage implements SessionStorage {
  static const _key = 'auth_session';
  final FlutterSecureStorage _storage;

  SecureSessionStorage(this._storage);

  @override
  Future<void> save(AuthSession session) async {
    final json = jsonEncode(_serialize(session));
    await _storage.write(key: _key, value: json);
  }

  @override

  Future<AuthSession?> load() async {
    final json = await _storage.read(key: _key);

    if (json == null) return null;

    final map = jsonDecode(json);
    return _deserialize(map);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _key);
  }

  Map<String, dynamic> _serialize(AuthSession session) {
    return {
      'accountId': session.accountId,
      'contextType': session.context.type.name,
      'tenantId': session.context.tenantId,
      'projectId': session.context.projectId,
      'issuedAt': session.issuedAt.toIso8601String(),
      'expiresAt': session.expiresAt.toIso8601String(),
    };
  }

  AuthSession _deserialize(Map<String, dynamic> map) {
    final contextType = AuthContextType.values.firstWhere(
      (e) => e.name == map['contextType'],
    );

    AuthContext context;

    switch (contextType) {
      case AuthContextType.system:
        context = const AuthContext.system();
        break;
      case AuthContextType.tenant:
        context = AuthContext.tenant(tenantId: map['tenantId']);
        break;
      case AuthContextType.project:
        context = AuthContext.project(
          tenantId: map['tenantId'],
          projectId: map['projectId'],
        );
        break;
    }

    return AuthSession(
      accountId: map['accountId'],
      context: context,
      issuedAt: DateTime.parse(map['issuedAt']),
      expiresAt: DateTime.parse(map['expiresAt']),
    );
  }
}
