// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:wellcare365/bootstrap/feature_config.dart';
// import 'package:wellcare365/features/auth/auth.dart';
// import 'package:wellcare365/features/dashboard/presentation/dashboard_page.dart';
// // import 'package:wellcare365/session/application/session_provider.dart';
// import 'package:go_router/go_router.dart';

// final appRouterProvider = Provider<GoRouter>((ref) {
//   final config = ref.read(featureConfigProvider);
//   // final session = ref.watch(sessionProvider);

//   return GoRouter(
//     initialLocation: '/login',
//     redirect: (_, _) {
//       // if (session.isUnknown) return null;

//       // if (config.devMode) return '/dashboard';

//       // if (config.auth && session.isUnauthenticated) return '/login';
//       // if (session.isAuthenticated && config.dashboard) return '/dashboard';

//       return null;
//     },
//     routes: [
//       if (config.auth)
//          GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
//       if (config.dashboard)
//         GoRoute(path: '/dashboard', builder: (_, _) => const DashboardPage()),
//     ],
//   );
// });


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wellcare365/bootstrap/feature_config.dart';

// Features
import 'package:wellcare365/features/auth/auth.dart';
import 'package:wellcare365/providers/auth_provider.dart';

import 'package:wellcare365/features/dashboard/presentation/dashboard_page.dart';


// Router
final appRouterProvider = Provider<GoRouter>((ref) {
  final config = ref.read(featureConfigProvider);
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/login',

    redirect: (context, state) {
      final isLoggedIn = authState.session != null;
      final isGoingToLogin = state.matchedLocation == '/login';

      // Nếu chưa login → luôn về login
      if (!isLoggedIn) {
        return isGoingToLogin ? null : '/login';
      }

      // Nếu đã login mà còn ở login → đi dashboard
      if (isLoggedIn && isGoingToLogin) {
        return '/dashboard';
      }

      return null;
    },

    routes: [
      if (config.auth)
        GoRoute(
          path: '/login',
          builder: (_, _) => const LoginPage(),
        ),

      if (config.dashboard)
        GoRoute(
          path: '/dashboard',
          builder: (_, _) => const DashboardPage(),
        ),
    ],
  );
});
