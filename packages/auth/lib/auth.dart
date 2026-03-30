library;

export 'src/presentation/login_page.dart';

export 'src/application/auth_facade.dart';
export 'src/application/command/login_command.dart';
export 'src/application/query/get_current_session_query.dart';

export 'src/domain/entity/account.dart';
export 'src/domain/entity/auth_session.dart';
export 'src/domain/value_object/auth_context.dart';
export 'src/domain/repository/auth_repository.dart';
export 'src/domain/repository/session_repository.dart';

export 'src/infrastructure/repository/session_repository_impl.dart';

/// Providers (DI)
export 'src/di/auth_provider.dart';