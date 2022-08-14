import 'package:go_router/go_router.dart';
import 'package:notewrite/presentation/screens/account_screen.dart';
import 'package:notewrite/presentation/screens/create_note_screen.dart';
import 'package:notewrite/presentation/screens/home_screen.dart';
import 'package:notewrite/presentation/screens/login_screen.dart';
import 'package:notewrite/presentation/screens/note_screen.dart';
import 'package:notewrite/presentation/screens/registration_screen.dart';
import 'package:notewrite/presentation/screens/signup_screen.dart';
import 'package:notewrite/presentation/screens/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      path: '/create-note',
      builder: (context, state) => const CreateNoteScreen(),
    ),
    GoRoute(
      path: '/note',
      builder: (context, state) {
        final id = state.queryParams['id'];
        return NoteScreen(
          id: id.toString(),
        );
      },
    ),
  ],
);
