import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_testing/constants/app_constants.dart';
import 'package:appwrite_testing/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDatabase {
  Databases databases =
      Databases(client, databaseId: AppConstants.usersDatabase);

  Future createUser(
    AppUser user,
    String uid,
    WidgetRef ref,
  ) async {
    await databases.createDocument(
      collectionId: AppConstants.userCollection,
      documentId: uid,
      read: ["role:all"],
      write: [
        "user:$uid",
      ],
      data: {
        "user_email": user.email,
        "user_name": user.name,
        "age": user.age,
      },
    );
  }

  Future<bool> checkUser(
    String uid,
  ) async {
    try {
      Document result = await databases.getDocument(
        collectionId: AppConstants.userCollection,
        documentId: uid,
      );
      if (result.$id == uid) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
