import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider((ref) => AuthServices(
    auth: FirebaseAuth.instance, firebaseStorage: FirebaseStorage.instance));

class AuthServices {
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;
  AuthServices({
    required this.auth,
    required this.firebaseStorage,
  });

  
}
