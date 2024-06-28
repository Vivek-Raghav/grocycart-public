import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/models/product.dart';
import '../../consts/authentication_consts.dart';
import '../../consts/globalWidget/error_dialog.dart';
import '../../models/user_model.dart';
import '../../widgets/app_routes.dart';
import '../../widgets/const_widgets.dart';
import '../shared_preferences.dart';

final authRepository = Provider((ref) => AuthRepository());

class AuthRepository {
  //
  //
  //  SIGN IN METHOD FOR THE EMAIL AND PASSWORD AND PUT DATA IN USER DOCUMENT by VIVEK RAGHAV
  //
  //

  void signUpWithEmail({
    required BuildContext context,
    required String email,
    required String fullName,
    required String profilePicURL,
    required List<String> addressList,
  }) async {
    try {
      final _uid = authInstance.currentUser!.uid;
      SharedPrefs().saveUID(_uid);
      // Initialize empty lists for cartlist and wishlist
      final List<Product> cartList = [];
      final List<Product> wishList = [];
      await firestoreInstance.collection('users').doc(_uid).set(
        {
          'profile': UserModel(
            uid: _uid,
            email: email,
            fullName: fullName,
            profilePic: profilePicURL,
            addressList: addressList,
          ).toMap(),
          'cartlist': cartList,
          'wishlist': wishList,
        },
      );
      navigateToPushReplacement(context, AppRoutes.bottomBar);
    } on FirebaseException catch (err) {
      showErrorDialog(context, err.message.toString());
      print('Error signUpWithEmail => ${err.message.toString()}');
    } catch (error) {
      showSnackBar(context, error.toString());
      print('Error signUpWithEmail => ${error.toString()}');
    }
  }
  //
  //
  //  SIGN IN METHOD FOR THE EMAIL AND PASSWORD AND PUT DATA IN USER DOCUMENT by VIVEK RAGHAV
  //
  //

  void resetPassword({
    required BuildContext context,
    required String email,
    required bool isLoading,
  }) async {
    try {
      authInstance.sendPasswordResetEmail(email: email.toLowerCase());
    } on FirebaseException catch (err) {
      showErrorDialog(context, err.message.toString());
      print('Error resetPassword => ${err.message.toString()}');
      isLoading = false;
    } catch (e) {
      showSnackBar(context, e.toString());
      print('Error resetPassword => ${e.toString()}');
    }
  }

  //
  //
  //  Here we are adding address in the user profile
  //
  //
  void addAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      final _uid = authInstance.currentUser!.uid;
      await firestoreInstance.collection('users').doc(_uid).update({
        'profile.addressList': FieldValue.arrayUnion([address])
      });
    } on FirebaseException catch (err) {
      showErrorDialog(context, err.message.toString());
      print('Error addAddress => ${err.message.toString()}');
    } catch (e) {
      showSnackBar(context, e.toString());
      print('Error addAddress => ${e.toString()}');
    }
  }

//
//
//
// Here we are checking the address
//
//

  Future<bool?> checkAddress({required BuildContext context}) async {
    try {
      final _uid = authInstance.currentUser!.uid;
      DocumentSnapshot docSnap =
          await firestoreInstance.collection('users').doc(_uid).get();
      if (docSnap.exists) {
        Map<String, dynamic>? userData =
            docSnap.data() as Map<String, dynamic>?;
        // && userData.containsKey('profile.addressList')
        if (userData != null) {
          print('CheckAddressFunction = > $docSnap');
          if (userData['profile']['addressList'] != null) {
            return true; // Address list exists and is not null
          }
        }
      }
      // Address list not found or is null
      return false;
    } on FirebaseException catch (err) {
      showErrorDialog(context, err.message.toString());
      print('Error addAddress => ${err.message.toString()}');
      return null;
    } catch (e) {
      showSnackBar(context, e.toString());
      print('Error addAddress => ${e.toString()}');
      return null;
    }
  }

  //
  //
  // Retrive address if available
  //
  //
  Future<List<String>?> showAddress({required BuildContext context}) async {
    try {
      final _uid = authInstance.currentUser!.uid;
      DocumentSnapshot docSnap =
          await firestoreInstance.collection('users').doc(_uid).get();
      if (docSnap.exists) {
        Map<String, dynamic>? userData =
            docSnap.data() as Map<String, dynamic>?;
        final addressData =
            userData!['profile']['addressList'] as List<dynamic>;
        final List<String>? addressList =
            addressData.map((e) => e.toString()).toList();
        print('ShowAddress Function => $addressData');
        return addressList;
      }
    } on FirebaseException catch (err) {
      showErrorDialog(context, err.message.toString());
      print('Error addAddress => ${err.message.toString()}');
      return null;
    } catch (e) {
      showSnackBar(context, e.toString());
      print('Error addAddress => ${e.toString()}');
      return null;
    }
    return null;
  }

  //
  //
  // HEre we are retreving the string details of the user like name , email etc...
  //
  //
  //

  Future<String?> retrieveUserDetail(String details) async {
    try {
      final uid = authInstance.currentUser!.uid;
      try {
        DocumentSnapshot userSnapshot =
            await firestoreInstance.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          // print('User Data: $userData');
          switch (details) {
            case 'username':
              return userData!['profile']['fullName'];
            case 'email':
              return userData!['profile']['email'];
            case 'profilePic':
              return userData!['profile']['profilePic'];
            // Add cases for other details as needed
            default:
              print('Invalid detail:');
              return null;
          }
          // Here, you can process or display the retrieved user data as needed
        } else {
          print('No user data found for UID: $uid');
          return null;
        }
      } catch (error) {
        print('Error retrieving user data: $error');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
