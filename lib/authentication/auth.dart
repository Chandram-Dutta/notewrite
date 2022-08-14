import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notewrite/provider/providers.dart';

import '../constants/app_constants.dart';

class Authentication {
  Future<String> login(
    String email,
    String pass,
    WidgetRef ref,
  ) async {
    Account account = Account(client);
    Session user;
    try {
      user = await account.createEmailSession(email: email, password: pass);
      ref.read(sesiIdProvider.state).state = user.$id;
      ref.read(currentUserProvider.state).state = await account.get();
      return 'Logged in Successfully';
    } on AppwriteException catch (e) {
      return e.message!;
    }
  }

  Future<String> oauthGoogleLogin(
    WidgetRef ref,
  ) async {
    Account account = Account(client);
    Session user;
    try {
      user = await account.createOAuth2Session(
        provider: 'google',
      );
      ref.read(sesiIdProvider.state).state = user.$id;
      ref.read(currentUserProvider.state).state = await account.get();
      return 'Logged in Successfully';
    } on AppwriteException catch (e) {
      return e.message!;
    }
  }

  Future<bool> isLoggedIn(
    WidgetRef ref,
  ) async {
    try {
      Account account = Account(client);
      Future<User> result = account.get();
      return result.then((value) {
        ref.read(currentUserProvider.state).state = value;
        return true;
      }).catchError((e) {
        return false;
      });
    } catch (e) {
      return false;
    }
  }

  Future<String> signUp(
      {required String email,
      required String pass,
      required String name,
      required WidgetRef ref}) async {
    Account account = Account(client);
    try {
      await account.create(
        userId: 'unique()',
        email: email,
        password: pass,
        name: name,
      );

      return 'Account Created';
    } on AppwriteException catch (e) {
      return e.message!;
    }
  }

  Future<bool> logout({
    required WidgetRef ref,
    required String sessId,
  }) async {
    Account account = Account(client);
    try {
      await account.deleteSession(sessionId: sessId);
      ref.read(sesiIdProvider.notifier).state = '';
      ref.refresh(sessionProvider);
      ref.refresh(currentUserProvider);
      return true;
    } on AppwriteException catch (e) {
      log(e.message.toString());
      return false;
    }
  }
}
