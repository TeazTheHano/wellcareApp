import 'package:wellcare365/features/auth/auth.dart';

class AuthSession {
  final String accountId;
  final AuthContext context;
  final DateTime issuedAt;
  final DateTime expiresAt;

  const AuthSession({
    required this.accountId,
    required this.context,
    required this.issuedAt,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
