import 'package:appwrite_testing/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GoRouter route = ref.watch(goRouterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appwrite Testing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () async {
              route.push('/account');
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
    );
  }
}
