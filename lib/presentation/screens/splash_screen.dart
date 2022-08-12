import 'package:appwrite_testing/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void route() async {
      bool val = await ref.watch(authProvider).isLoggedIn(ref);
      if (val) {
        ref.watch(goRouterProvider).go('/home');
      } else {
        ref.watch(goRouterProvider).go('/login');
      }
    }

    route();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/built-with-appwrite.svg",
              width: 500,
              height: 200,
            ),
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
