class UserModel {
  final String uid; // Unique identifier for the user
  final String email; // Email of the user
  final String fullName; // Full name of the user
  final String? profilePic; // URL of the user's profile picture
  final List<String> addressList; // List of products in the user's wishlist

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.profilePic,
    required this.addressList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'profilePic': profilePic,
      'addressList': addressList,
    };
  }
}
