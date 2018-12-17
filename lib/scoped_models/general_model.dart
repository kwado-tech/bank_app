
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/models/user.dart';

import 'package:bank_app/services/auth_service.dart';
import 'package:bank_app/services/profile_service.dart';

mixin GeneralModel implements Model {
  bool isLoading = false;
  User authenticatedUser;
  

  final authService = AuthService();
  final profileService = ProfileService();
}