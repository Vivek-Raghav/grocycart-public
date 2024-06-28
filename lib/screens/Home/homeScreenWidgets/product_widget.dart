import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductWidget extends StatefulWidget {
  final String title;
  final bool isDarkTheme;
  final Color color;
  final double price;
  final String imageLink;
  final String itemWeight;
  final VoidCallback onTap;
  final VoidCallback onTapWishlist;
  final VoidCallback onTapForAdd;

  const ProductWidget({
    Key? key,
    required this.title,
    required this.isDarkTheme,
    required this.color,
    required this.price,
    required this.imageLink,
    required this.itemWeight,
    required this.onTap,
    required this.onTapWishlist,
    required this.onTapForAdd,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height * 0.23,
        width: size.width * 0.5 - 10, // Adjust the width as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.color.withOpacity(0.08),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height * 0.14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageLink),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(
                      10.0), // Optional: Add border radius
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: widget.onTapWishlist,
                        icon: const Icon(IconlyLight.heart),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              // Title

              Padding(
                padding: const EdgeInsets.only(top: 2.0, right: 2, left: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '  ₹${widget.price}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.itemWeight,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: widget.onTapForAdd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                        0xFF67c766), // Set the button color// Set padding around the text
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0), // Set border radius
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set text color
                    ),
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
