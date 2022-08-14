import 'dart:io' as io;

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class ProfilePictureStorage {
  Storage storage = Storage(client);
  Future uploadProfilePicture(
    String uid,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      io.File file = io.File(result.files.single.path.toString());
      return await storage.createFile(
        fileId: uid,
        bucketId: AppConstants.profilePictureBucket,
        file: InputFile(path: file.path),
      );
    }
  }

  Future getProfilePictureData(
    String uid,
  ) async {
    Future<File> result = storage.getFile(
      bucketId: AppConstants.profilePictureBucket,
      fileId: uid,
    );

    result.then((response) {
      return (response.$id);
    }).catchError((error) {
      return (error);
    });
  }

  Widget getProfilePicture(
    String uid,
  ) {
    return FutureBuilder(
      future: storage.getFileView(
        bucketId: AppConstants.profilePictureBucket,
        fileId: uid,
      ),
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData && snapshot.data != null
            ? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(
                  snapshot.data,
                ),
              )
            : const Icon(
                Icons.person_add,
                size: 50,
              );
      },
    );
  }
}
