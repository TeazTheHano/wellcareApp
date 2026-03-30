import 'package:flutter_riverpod/legacy.dart';
import 'package:auth/auth.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final AuthSession? session;

  const AuthState({this.isLoading = false, this.error, this.session});

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthSession? session,
    bool clearSession = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      session: clearSession ? null : (session ?? this.session),
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  final AuthFacade facade;
  AuthController({required this.facade}) : super(const AuthState());


  /// Login with email and password.
  ///
  /// If successful, the user is logged in and the session is updated.
  /// If not successful, an error message is displayed.
  Future<void> login({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final session = await facade.login(email, password);
      state = state.copyWith(isLoading: false, session: session);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await facade.logout();
    state = state.copyWith(clearSession: true);
  }

  Future<void> restore() async {
    final session = await facade.restore();
    if (session == null) {
      state = state.copyWith(clearSession: true);
    } else {
      state = state.copyWith(session: session);
    }
  }
}