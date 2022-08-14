import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notewrite/authentication/auth.dart';
import 'package:notewrite/database/note_database.dart';
import 'package:notewrite/database/user_database.dart';
import 'package:notewrite/models/note_model.dart';
import 'package:notewrite/routes/go_routes.dart';
import 'package:notewrite/storage/profile_picture_storage.dart';
import 'package:notewrite/themes/theme.dart';

final sesiIdProvider = StateProvider((ref) => '');
final sessionProvider = StateProvider<Session>((ref) => session1);
final currentUserProvider = StateProvider<User>((ref) => user1);
final goRouterProvider = Provider<GoRouter>((ref) {
  return router;
});
final appThemeProvider = ChangeNotifierProvider<AppTheme>((ref) {
  return AppTheme();
});
final authProvider = Provider<Authentication>((ref) {
  return Authentication();
});
final userDatabaseProvider = Provider<UserDatabase>((ref) {
  return UserDatabase();
});
final noteDatabaseProvider = Provider<NoteDatabase>((ref) {
  return NoteDatabase();
});
final editNoteProvider = StateProvider<Note>((ref) {
  return Note(userId: "", title: "", body: "");
});
final profilePictureStorageProvider = Provider<ProfilePictureStorage>((ref) {
  return ProfilePictureStorage();
});
Session session1 = Session(
  $id: '',
  $createdAt: 1588888888,
  userId: '',
  expire: 1588888888,
  provider: '',
  providerUid: '',
  providerAccessToken: '',
  providerAccessTokenExpiry: 1588888888,
  providerRefreshToken: '',
  ip: '',
  osCode: '',
  osName: '',
  osVersion: '',
  clientType: '',
  clientCode: '',
  clientName: '',
  clientVersion: '',
  clientEngine: '',
  clientEngineVersion: '',
  deviceName: '',
  deviceModel: '',
  deviceBrand: '',
  countryCode: '',
  countryName: '',
  current: true,
);

User user1 = User(
  $id: '',
  $createdAt: 0,
  $updatedAt: 0,
  name: '',
  registration: 0,
  status: false,
  passwordUpdate: 0,
  email: '',
  phone: '',
  emailVerification: false,
  phoneVerification: false,
  prefs: Preferences(
    data: {},
  ),
);
