import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_testing/constants/app_constants.dart';
import 'package:appwrite_testing/models/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteDatabase {
  Databases databases =
      Databases(client, databaseId: AppConstants.notesDatabase);

  Future createNote(
    Note note,
    String uid,
    WidgetRef ref,
  ) async {
    await databases.createDocument(
      collectionId: AppConstants.noteCollection,
      documentId: "unique()",
      read: ["user:$uid"],
      write: [
        "user:$uid",
      ],
      data: {
        "title": note.title,
        "body": note.body,
        "user_id": note.userId,
      },
    );
  }

  Future<List<Document>> getNotes() async {
    DocumentList result = await databases.listDocuments(
      collectionId: AppConstants.noteCollection,
    );
    return result.documents;
  }
}
