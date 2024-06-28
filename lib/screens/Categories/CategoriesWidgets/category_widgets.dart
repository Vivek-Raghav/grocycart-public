// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final bool isDarkTheme;
  final Color color;
  final String imageLink;
  final VoidCallback onTap;

  const CategoryContainer({
    Key? key,
    required this.title,
    required this.isDarkTheme,
    required this.color,
    required this.imageLink,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: size.height * 0.28, // Adjust the height as needed
        width: size.width * 0.5 - 20, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color.withOpacity(0.3),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height * 0.16, // Adjust the height as needed
                width: size.width * 0.5 - 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageLink),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius
                ),
              ),
              // Title
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 3),
                  color: color,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
