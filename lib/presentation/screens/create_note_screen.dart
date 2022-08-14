import 'package:notewrite/models/note_model.dart';
import 'package:notewrite/presentation/widgets/loading_dialog.dart';
import 'package:notewrite/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateNoteScreen extends ConsumerWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter route = ref.watch(goRouterProvider);
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showLoaderDialog(context);
          await ref.watch(noteDatabaseProvider).createNote(
                Note(
                  title: titleController.text,
                  body: bodyController.text,
                  userId: ref.watch(currentUserProvider).$id,
                ),
                ref.watch(currentUserProvider).$id,
                ref,
              );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          route.pop();
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
                labelText: "Title", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: bodyController,
            decoration: const InputDecoration(
                labelText: "Body", border: OutlineInputBorder()),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
