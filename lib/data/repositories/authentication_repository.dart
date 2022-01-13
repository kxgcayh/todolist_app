import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authenticationRepository = ChangeNotifierProvider((ref) {
  return AuthenticationRepository();
});

class AuthenticationRepository extends ChangeNotifier {
  late UserModel user;

  void login(String username, String token) {
    user = UserModel(username, token: token);
    notifyListeners();
  }
}

class UserModel extends Equatable {
  const UserModel(this.username, {this.token});
  final String? username;
  final String? token;

  @override
  List<Object?> get props => [username, token];
}
