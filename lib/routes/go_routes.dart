import 'package:appwrite_testing/presentation/screens/account_screen.dart';
import 'package:appwrite_testing/presentation/screens/create_note_screen.dart';
import 'package:appwrite_testing/presentation/screens/home_screen.dart';
import 'package:appwrite_testing/presentation/screens/login_screen.dart';
import 'package:appwrite_testing/presentation/screens/note_screen.dart';
import 'package:appwrite_testing/presentation/screens/registration_screen.dart';
import 'package:appwrite_testing/presentation/screens/signup_screen.dart';
import 'package:appwrite_testing/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

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
      builder: (context, state) => const ResgistrationScreen(),
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
        final title = state.queryParams['title'];
        final body = state.queryParams['body'];
        return NoteScreen(
          title: title.toString(),
          body: body.toString(),
        );
      },
    ),
  ],
);
