import 'package:appwrite_testing/presentation/widgets/change_theme_button.dart';
import 'package:appwrite_testing/presentation/widgets/loading_dialog.dart';
import 'package:appwrite_testing/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter router = ref.watch(goRouterProvider);

    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
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
                  labelText: "Name",
                ),
                controller: nameController,
              ),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showLoaderDialog(context);
                        String msg = await ref.watch(authProvider).signUp(
                            email: emailController.text,
                            pass: passwordController.text,
                            name: nameController.text,
                            ref: ref);
                        if (msg == 'Account Created') {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text("Account Created"),
                                content: const Text(
                                    "Your Account has been created successfully. You can now login to your account."),
                                actions: [
                                  CupertinoDialogAction(
                                      child: const Text("Login"),
                                      onPressed: () {
                                        router.go('/login');
                                      }),
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
                        } else {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text("Account Creation Unsuccessful"),
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
                      child: const Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        router.go('/login');
                      },
                      child: const Text("Log In"),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
