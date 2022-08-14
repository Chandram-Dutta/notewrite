// ignore_for_file: use_build_context_synchronously

import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/presentation/widgets/timestamp.dart';
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
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   tooltip: 'Refresh List',
            //   onPressed: () async {
            //     await ref.refresh(noteDatabaseProvider).getNotes();
            //   },
            // ),
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
                  return Dismissible(
                    confirmDismiss: (direction) {
                      return showCupertinoDialog<bool>(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'This note will be deleted permanently.'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) async {
                      await ref
                          .watch(noteDatabaseProvider)
                          .deleteNote(snapshot.data![index].$id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('The note has been deleted.')));
                      await ref.refresh(noteDatabaseProvider).getNotes();
                    },
                    key: UniqueKey(),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                route.push(
                                  '/note?id=${snapshot.data?.elementAt(index).$id}',
                                );
                              },
                              title: Text(snapshot.data
                                      ?.elementAt(index)
                                      .data['title'] ??
                                  ''),
                              subtitle: Text(
                                snapshot.data?.elementAt(index).data['body'] ??
                                    '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Divider(),
                            Text(
                              "Last Updated ${readTimestamp(snapshot.data?.elementAt(index).$updatedAt)}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.create, size: 100),
                  Text('Create a Note'),
                ],
              ));
            }
          },
          future: list,
        ));
  }
}
