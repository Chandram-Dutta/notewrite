import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/models/note_model.dart';
import 'package:notewrite/presentation/widgets/loading_dialog.dart';
import 'package:notewrite/provider/providers.dart';

class EditScreen extends ConsumerStatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoRouter route = ref.watch(goRouterProvider);
    TextEditingController titleController = TextEditingController(
      text: ref.watch(editNoteProvider).title,
    );
    TextEditingController bodyController = TextEditingController(
      text: ref.watch(editNoteProvider).body,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showLoaderDialog(context);
          await ref.watch(noteDatabaseProvider).updateNote(
                Note(
                  title: titleController.text,
                  body: bodyController.text,
                  userId: ref.watch(currentUserProvider).$id,
                ),
                ref.watch(editNoteProvider).userId,
              );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          route.pop();
          route.pop();
          route.push('/note?id=${ref.watch(editNoteProvider).userId}');
        },
        label: const Text("Update"),
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
