import 'package:appwrite/models.dart';
import 'package:appwrite_testing/authentication/auth.dart';
import 'package:appwrite_testing/database/note_database.dart';
import 'package:appwrite_testing/database/user_database.dart';
import 'package:appwrite_testing/routes/go_routes.dart';
import 'package:appwrite_testing/themes/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
