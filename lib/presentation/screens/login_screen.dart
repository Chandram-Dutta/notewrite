import 'package:appwrite_testing/presentation/widgets/change_theme_button.dart';
import 'package:appwrite_testing/presentation/widgets/loading_dialog.dart';
import 'package:appwrite_testing/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter router = ref.watch(goRouterProvider);

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          actions: const [
            ChangeThemeButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: ListView(children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                controller: emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showLoaderDialog(context);
                        String msg = await ref.watch(authProvider).login(
                            emailController.text, passwordController.text, ref);

                        if (msg == 'Logged in Successfully') {
                          if (!await ref
                              .watch(userDatabaseProvider)
                              .checkUser(ref.watch(currentUserProvider).$id)) {
                            router.go('/registration');
                          } else {
                            router.go('/home');
                          }
                        } else {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text("Account Log In Unsuccessful"),
                                content: Text(msg),
                                actions: [
                                  CupertinoDialogAction(
                                      child: const Text("Back"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showLoaderDialog(context);
                        String msg =
                            await ref.watch(authProvider).oauthGoogleLogin(ref);

                        if (msg == 'Logged in Successfully') {
                          router.go('/home');
                        } else {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text("Account Log In Unsuccessful"),
                                content: Text(msg),
                                actions: [
                                  CupertinoDialogAction(
                                      child: const Text("Back"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Google Login"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        router.go('/signup');
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
