import 'package:flutter_test/flutter_test.dart';
import 'package:wellcare365/features/auth/src/infrastructure/repository/fake_auth_repository.dart';
import 'package:wellcare365/features/auth/src/domain/value_object/auth_context.dart';

void main() {
  late FakeAuthRepository repository;

  setUp(() {
    repository = FakeAuthRepository();
  });

  group('FakeAuthRepository', () {
    test('authenticate returns Account', () async {
      final account = await repository.authenticate(
        email: 'system@dev.com',
        password: '123456',
      );

      expect(account.accountId, isNotEmpty);
      expect(account.email, equals('system@dev.com'));
    });

    test('resolveInitialContext returns system context', () async {
      await repository.authenticate(
        email: 'system@dev.com',
        password: '123456',
      );

      final context = await repository.resolveInitialContext(
        accountId: 'dummy',
      );

      expect(context.type, AuthContextType.system);
    });

    test('resolveInitialContext returns tenant context', () async {
      await repository.authenticate(
        email: 'tenant@dev.com',
        password: '123456',
      );

      final context = await repository.resolveInitialContext(
        accountId: 'dummy',
      );

      expect(context.type, AuthContextType.tenant);
      expect(context.tenantId, isNotNull);
    });

    test('resolveInitialContext returns project context', () async {
      await repository.authenticate(
        email: 'user@dev.com',
        password: '123456',
      );

      final context = await repository.resolveInitialContext(
        accountId: 'dummy',
      );

      expect(context.type, AuthContextType.project);
      expect(context.projectId, isNotNull);
    });
  });
}
