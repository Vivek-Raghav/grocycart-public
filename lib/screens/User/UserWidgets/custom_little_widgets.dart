import 'package:flutter/material.dart';

Widget customListile(
  bool isDarkTheme,
  String address,
  String? subtitle,
  IconData leading,
  IconData trailing,
  VoidCallback onTap,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: ListTile(
      onTap: onTap,
      title: Text(
        address,
        style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 13),
            )
          : null,
      leading: Icon(
        leading,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      trailing: Icon(
        trailing,
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
    ),
  );
}
