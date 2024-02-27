// Import necessary packages
import 'package:flutter/material.dart'; // Flutter material library for UI components
import 'package:app/DrList.dart'; // Import DrList widget for navigating to doctor list

// Category block widget
class CatBlock extends StatelessWidget {
  final String name; // Name of the category
  final String imageUrl; // Image URL for the category

  // Constructor for CatBlock widget
  const CatBlock({
    Key? key,
    required this.name, // Required parameter: name
    required this.imageUrl, // Required parameter: imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gesture detector to detect taps
    return GestureDetector(
      onTap: () {
        // Navigate to DrList screen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DrList(category: name), // Pass category name to DrList
          ),
        );
      },
      child: Container(
        // Container for category block
        margin:
            EdgeInsets.symmetric(horizontal: 15), // Margin around the container
        decoration: BoxDecoration(
          // Decoration for container
          borderRadius: BorderRadius.circular(20), // Border radius
          boxShadow: [
            // Box shadow for container
            BoxShadow(
              color:
                  Colors.black87.withOpacity(0.3), // Shadow color with opacity
              spreadRadius: 1, // Spread radius
              blurRadius: 10, // Blur radius
              offset: Offset(0, 5), // Shadow offset
            ),
          ],
        ),
        child: Stack(
          // Stack to layer widgets
          children: [
            ClipRRect(
              // Clip rounded rectangle for image
              borderRadius: BorderRadius.circular(20), // Border radius
              child: Image.network(
                // Network image
                imageUrl, // Image URL from parameter
                height: 110, // Image height
                width: 110, // Image width
                fit: BoxFit.cover, // Image fit
              ),
            ),
            Container(
              // Transparent container for overlay
              height: 100, // Container height
              width: 100, // Container width
              decoration: BoxDecoration(
                // Decoration for container
                color: Colors.transparent, // Transparent color
                borderRadius: BorderRadius.circular(12), // Border radius
              ),
            ),
            Positioned(
              // Positioned widget for text position
              left: 10, // Left position
              bottom: 5, // Bottom position
              child: Text(
                name, // Category name from parameter
                style: TextStyle(
                  color: Colors.transparent, // Text color
                  fontWeight: FontWeight.w600, // Text weight
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
