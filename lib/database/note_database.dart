import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:notewrite/constants/app_constants.dart';
import 'package:notewrite/models/note_model.dart';

class NoteDatabase {
  Databases databases =
      Databases(client, databaseId: AppConstants.notesDatabase);

  Future createNote(
    Note note,
    String uid,
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

  Future deleteNote(
    String id,
  ) async {
    await databases.deleteDocument(
      collectionId: AppConstants.noteCollection,
      documentId: id,
    );
  }

  Future<List<Document>> getNotes() async {
    DocumentList result = await databases.listDocuments(
      collectionId: AppConstants.noteCollection,
    );
    return result.documents;
  }

  Future<Note> getNote(
    String id,
  ) async {
    Document result = await databases.getDocument(
      collectionId: AppConstants.noteCollection,
      documentId: id,
    );
    return Note(
        body: result.data["body"],
        title: result.data["title"],
        userId: result.data["user_id"]);
  }
}
