import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth authInstance = FirebaseAuth.instance;
final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
final currentUser = authInstance.currentUser;
final uidUser = authInstance.currentUser!.uid;
