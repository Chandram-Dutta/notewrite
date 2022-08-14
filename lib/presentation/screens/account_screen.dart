import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/presentation/widgets/change_theme_button.dart';
import 'package:notewrite/presentation/widgets/loading_dialog.dart';
import 'package:notewrite/presentation/widgets/timestamp.dart';
import 'package:notewrite/provider/providers.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User userProvider = ref.watch(currentUserProvider);
    GoRouter route = ref.watch(goRouterProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Account"),
          actions: const [ChangeThemeButton()],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () async {
                  await ref
                      .watch(profilePictureStorageProvider)
                      .uploadProfilePicture(ref.watch(currentUserProvider).$id);

                  ref
                      .refresh(profilePictureStorageProvider)
                      .getProfilePicture(ref.watch(currentUserProvider).$id);
                },
                child: ref
                    .watch(profilePictureStorageProvider)
                    .getProfilePicture(userProvider.$id),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Email"),
                subtitle: Text(userProvider.email),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("Name"),
                subtitle: Text(userProvider.name),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text("User Created On"),
                subtitle: Text(readTimestamp(userProvider.$createdAt)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 70,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.error),
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onError),
                  ),
                  onPressed: () async {
                    showLoaderDialog(context);
                    bool msg = await ref.watch(authProvider).logout(
                          ref: ref,
                          sessId: ref.watch(sesiIdProvider),
                        );
                    if (msg) {
                      route.go('/login');
                    } else {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text("Account Log Out Unsuccessful"),
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
                  child: const Text("Logout"),
                ),
              ),
            ),
          ],
        ));
  }
}
