import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/room_detail/room_detail_screen.dart';
import '../../features/schedule/schedule_screen.dart';
import '../../features/favorites/favorites_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../core/constants/app_constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: AppConstants.screenTransition,
          ),
        ),
        GoRoute(
          path: '/favorites',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const FavoritesScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: AppConstants.screenTransition,
          ),
        ),
        GoRoute(
          path: '/schedule',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ScheduleScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: AppConstants.screenTransition,
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const ProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: AppConstants.screenTransition,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/room/:id',
      builder: (context, state) {
        final roomId = int.parse(state.pathParameters['id']!);
        return RoomDetailScreen(roomId: roomId);
      },
    ),
  ],
);

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const _routes = ['/home', '/favorites', '/schedule', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i])) {
        _currentIndex = i;
        break;
      }
    }

    return Scaffold(
      body: widget.child,
      extendBody: true,
      bottomNavigationBar: GlassBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 4) {
            // Center FAB — placeholder, navigate home
            context.go('/home');
            return;
          }
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            context.go(_routes[index]);
          }
        },
      ),
    );
  }
}
