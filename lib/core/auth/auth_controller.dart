import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_repository.dart';
import 'package:healthy_medicine_2/core/providers/storage_repository_provider.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/core/models/user_model.dart';
import 'package:routemaster/routemaster.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  ((ref) {
    final storageRepository = ref.watch(storageRepositoryProvider);
    return AuthController(
      authRepository: ref.watch(authRepositoryProvider),
      storageRepository: storageRepository,
      ref: ref,
    );
  }),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final getUsersDoctorsProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUsersDoctors();
});

final getUsersAdminsProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUsersAdmins();
});

final getAllUsersProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getAllUsers();
});

final getUsersProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUsers();
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _authRepository = authRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false); // loading

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signIn(BuildContext context, String email, String password) async {
    state = true;
    final user = await _authRepository.signIn(email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signUp(
    BuildContext context,
    String email,
    String password,
    String firstName,
    String lastName,
    String patronymic,
    String avatar,
    String gender,
    String phone,
    String city,
    DateTime birthday,
    bool isDoctor,
    String doctorId,
  ) async {
    state = true;
    final user = await _authRepository.signUp(
        email,
        password,
        firstName,
        lastName,
        patronymic,
        avatar,
        gender,
        phone,
        city,
        birthday,
        isDoctor,
        doctorId);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<List<UserModel>> getUsersDoctors() {
    return _authRepository.getUsersDoctors();
  }

  Stream<List<UserModel>> getUsersAdmins() {
    return _authRepository.getUsersAdmins();
  }

  Stream<List<UserModel>> getAllUsers() {
    return _authRepository.getAllUsers();
  }

  Stream<List<UserModel>> getUsers() {
    return _authRepository.getUsers();
  }

  void editUser({
    required File? profileFile,
    required Uint8List? profileWebFile,
    required BuildContext context,
    required UserModel user,
    required bool isPicPicked,
  }) async {
    state = true;
    if (profileFile != null || profileWebFile != null && isPicPicked == true) {
      // communities/profile/memes
      final res = await _storageRepository.storeFile(
        path: 'users/avatars/',
        id: user.uid,
        file: profileFile,
        webFile: profileWebFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => user = user.copyWith(avatar: r),
      );
    }

    final res = await _authRepository.editUser(user);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Вы изменили свой профиль!');
      Routemaster.of(context).pop();
    });
  }

  void logOut() async {
    _authRepository.logOut();
  }
}
