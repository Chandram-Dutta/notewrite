// ignore_for_file: use_build_context_synchronously

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/models/user_model.dart';
import 'package:notewrite/presentation/widgets/loading_dialog.dart';
import 'package:notewrite/provider/providers.dart';
import 'package:numberpicker/numberpicker.dart';

final numberPickerProvider = StateProvider<int>((ref) {
  return 1;
});

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User userProvider = ref.watch(currentUserProvider);
    GoRouter route = ref.watch(goRouterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Column(children: [
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Spacer(),
              const Text("Choose Your Age"),
              const Spacer(),
              NumberPicker(
                value: ref.watch(numberPickerProvider),
                minValue: 1,
                maxValue: 100,
                onChanged: (value) =>
                    ref.read(numberPickerProvider.state).state = value,
                axis: Axis.vertical,
                haptics: true,
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                showLoaderDialog(context);
                await ref.watch(userDatabaseProvider).createUser(
                    AppUser(
                        email: userProvider.email,
                        name: userProvider.name,
                        age: ref.watch(numberPickerProvider)),
                    userProvider.$id,
                    ref);
                route.go('/home');
              },
              child: const Text("Register"),
            ),
          ),
        ),
      ]),
    );
  }
}
