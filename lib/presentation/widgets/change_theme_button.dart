
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notewrite/provider/providers.dart';

class ChangeThemeButton extends ConsumerWidget {
  const ChangeThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: "Change Theme",
      onPressed: () {
        if (Theme.of(context).brightness == Brightness.light) {
          ref.watch(appThemeProvider).changeToDarkTheme();
        } else {
          ref.watch(appThemeProvider).changeToLightTheme();
        }
      },
      icon: Theme.of(context).brightness == Brightness.light
          ? const Icon(Icons.sunny)
          : const Icon(Icons.dark_mode_rounded),
    );
  }
}
