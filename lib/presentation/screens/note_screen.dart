import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notewrite/presentation/widgets/change_theme_button.dart';

class NoteScreen extends ConsumerWidget {
  const NoteScreen({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          title,
          maxLines: 1,
        ),
        actions: const [ChangeThemeButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),
      body: ListView(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(body),
          ),
        ),
      ]),
    );
  }
}
