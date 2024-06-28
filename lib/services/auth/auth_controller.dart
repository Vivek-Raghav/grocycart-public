import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/services/auth/auth_repository.dart';

final authController = Provider(
  (ref) => AuthController(
    ref: ref,
    authRepository: AuthRepository(),
  ),
);

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;

  AuthController({
    required this.ref,
    required this.authRepository,
  });
//
//
// Controller is create for signInWithEmailandPassword by Vivek Raghav
//
  void signUpWithEmail({
    required BuildContext context,
    required String email,
    required String fullName,
    required String profilePicURL,
    required List<String> addressList,
  }) {
    authRepository.signUpWithEmail(
      context: context,
      email: email,
      fullName: fullName,
      profilePicURL: profilePicURL,
      addressList: addressList,
    );
  }

  //
  //
  // Controller create for resetting the password
  //
  //
  //
  void resetPassword({
    required BuildContext context,
    required String email,
    required bool isLoading,
  }) {
    authRepository.resetPassword(
      context: context,
      email: email,
      isLoading: isLoading,
    );
  }

  //
  //
  // add address
  //
  //
  void addAddress({required BuildContext context, required String address}) {
    authRepository.addAddress(context: context, address: address);
  }

  //
  //
  //Check address if it is available or not
  //
  //
  Future<bool?> checkAddress({required BuildContext context}) {
    return authRepository.checkAddress(context: context);
  }

  //
  //
  //
  //
  // Show the address
  //
  //
  //
  //

  Future<List<String>?> showAddress({required BuildContext context}) {
    return authRepository.showAddress(context: context);
  }
}
