import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
//
//---------------------------SAVING THE PREFS VALUES-------------------------------------
//
//

  Future<void> isUserLoggedIn(bool userLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogin', userLogin);
    print('User Login saved: $userLogin');
  }

  Future<void> saveUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    print('UID saved: $uid');
  }

  //
  //
  // -----------------------SAVING THE VALUES ENDS HERE ----------------------
  //
  //

// ---------------------------------------------------------------------------------------------------------

  //
  //
  //---------------------------RETREIVING THE VALUES START----------------------------------------
  //
  //
  //

  Future<bool> getUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? userLoggedIn = prefs.getBool('userLogin');
    return userLoggedIn ?? false; // If userLoggedIn is null, return false
  }

  // Function to retrieve the UID
  Future<String?> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    print('UID retrieved: $uid');
    return uid;
  }

  //
  //
  //
  //------------------------- RETRIEVING THE VALUES ENDS HERE -------------------------------------------------
  //
  //
}
