import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notewrite/models/note_model.dart';
import 'package:notewrite/presentation/widgets/change_theme_button.dart';
import 'package:notewrite/provider/providers.dart';

class NoteScreen extends ConsumerWidget {
  const NoteScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<Note> note = ref.watch(noteDatabaseProvider).getNote(id);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            initialData: Note(body: "...", userId: "...", title: "..."),
            future: note,
            builder: (context, AsyncSnapshot<Note> snapshot) {
              return SelectableText(
                snapshot.data?.title ?? '',
                maxLines: 1,
              );
            }),
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
            child: FutureBuilder(
                initialData: Note(body: "...", userId: "...", title: "..."),
                future: note,
                builder: (context, AsyncSnapshot<Note> snapshot) {
                  return SelectableText(
                    snapshot.data?.body ?? '',
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
