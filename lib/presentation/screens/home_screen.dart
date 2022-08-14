import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/provider/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter route = ref.watch(goRouterProvider);
    Future<List<Document>> list = ref.watch(noteDatabaseProvider).getNotes();

    return Scaffold(
        appBar: AppBar(
          title: const Text('NoteWrite'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile',
              onPressed: () async {
                route.push('/account');
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh List',
              onPressed: () async {
                await ref.refresh(noteDatabaseProvider).getNotes();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            route.push('/create-note');
          },
          icon: const Icon(Icons.add),
          label: const Text('Create a Note'),
        ),
        body: FutureBuilder(
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        route.push(
                          '/note?title=${snapshot.data?.elementAt(index).data['title'] ?? ''}&body=${snapshot.data?.elementAt(index).data['body']}',
                        );
                      },
                      title: Text(
                          snapshot.data?.elementAt(index).data['title'] ?? ''),
                      subtitle: Text(
                        snapshot.data?.elementAt(index).data['body'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return const Center(child: Text("Create a Note"));
            }
          },
          future: list,
        ));
  }
}
