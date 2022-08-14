import 'package:appwrite/appwrite.dart';

Client client = Client();
Account globalAccount = Account(client);

class AppConstants {
  AppConstants._();
  static const String projectId = '62f210e32ae77d035ee9'; // Your project ID
  static const String endPoint =
      'http://localhost/v1'; // Your Appwrite Endpoint
  static const String usersDatabase = '62f4db23ad3c38fcecc7';
  static const String userCollection = '62f4db3d8fb92380cd56';
  static const String notesDatabase = '62f5fd5a981fc04ab316';
  static const String noteCollection = '62f5fd63d8056e3ba81a';
  static const String profilePictureBucket = '62f8ba1393c293f35d6c';
}
