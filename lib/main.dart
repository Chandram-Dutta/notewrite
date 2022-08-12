import 'package:appwrite_testing/constants/app_constants.dart';
import 'package:appwrite_testing/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  client
      .setEndpoint(AppConstants.endPoint)
      .setProject(AppConstants.projectId)
      .setSelfSigned(status: true);
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Appwrite Testing',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ref.watch(appThemeProvider).appColorScheme,
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
