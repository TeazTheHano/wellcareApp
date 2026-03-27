import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcare365/providers/auth_provider.dart';
import 'package:wellcare365/features/auth/src/infrastructure/repository/fake_auth_repository.dart';
import 'package:wellcare365/features/auth/src/domain/value_object/auth_context.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(
          FakeAuthRepository(),
        ),
        // dùng in-memory storage thật
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthController', () {
    test('initial state is unauthenticated', () {
      final state = container.read(authControllerProvider);
      expect(state.session, isNull);
      expect(state.isLoading, false);
    });

    test('login creates session with correct role', () async {
      final controller =
          container.read(authControllerProvider.notifier);

      await controller.login(
        email: 'system@dev.com',
        password: '123456',
      );

      final state = container.read(authControllerProvider);

      expect(state.session, isNotNull);
      expect(state.session!.context.type,
          equals(AuthContextType.system));
      expect(state.session!.isExpired, false);
    });

    test('logout clears session state', () async {
      final controller =
          container.read(authControllerProvider.notifier);

      await controller.login(
        email: 'system@dev.com',
        password: '123456',
      );

      await controller.logout();

      final state = container.read(authControllerProvider);

      expect(state.session, isNull);
    });

    test('restore returns existing valid session', () async {
      final controller =
          container.read(authControllerProvider.notifier);

      await controller.login(
        email: 'tenant@dev.com',
        password: '123456',
      );

      // simulate app restart
      await controller.restore();

      final state = container.read(authControllerProvider);

      expect(state.session, isNotNull);
      expect(state.session!.context.type,
          equals(AuthContextType.tenant));
    });

    test('expired session is cleared on restore', () async {
      // override TTL ngắn để test expire
      final shortTtlContainer = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(),
          ),
          sessionTtlProvider.overrideWithValue(
            Duration(milliseconds: 10),
          ),
        ],
      );

      final controller =
          shortTtlContainer.read(authControllerProvider.notifier);

      await controller.login(
        email: 'system@dev.com',
        password: '123456',
      );

      await Future.delayed(Duration(milliseconds: 20));

      await controller.restore();

      final state =
          shortTtlContainer.read(authControllerProvider);

      expect(state.session, isNull);

      shortTtlContainer.dispose();
    });
  });
}
