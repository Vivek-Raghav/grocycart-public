import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocycart/consts/consts.dart';
import 'package:grocycart/widgets/TextWidget/text_widget.dart';
import '../../../consts/theme_provider.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/myprofileScreen';
  const MyProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = ref.read(themeProvider);
    Color color = isDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          content: 'Profile',
          fontSize: 24,
          color: color,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: 3.0,
                  ),
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(constProfilePicURL),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextWidget(
              content: 'User Details',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person, color: color), // Icon before name
              title: TextWidget(
                content: 'Name',
                fontSize: 18,
                color: color,
              ),
              subtitle: TextWidget(
                content: constName,
                fontSize: 18,
                color: color,
              ),
            ),
            ListTile(
              leading: Icon(Icons.email, color: color), // Icon before email
              title: TextWidget(
                content: 'Email',
                fontSize: 18,
                color: color,
              ),
              subtitle: TextWidget(
                content: constEmail,
                fontSize: 18,
                color: color,
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: color), // Icon before phone
              title: TextWidget(
                content: 'Phone',
                fontSize: 18,
                color: color,
              ),
              subtitle: TextWidget(
                content: '+1234567890',
                fontSize: 18,
                color: color,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button press
              },
              child: const TextWidget(
                content: 'Edit Profile',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
