// Import necessary packages
import 'dart:ui'; // Dart UI library for image filters
import 'package:flutter/material.dart'; // Flutter material library for UI components

// Class to hold UI helper methods
class UiHelper {
  // Custom text field widget
  static CustomTextfield(TextEditingController controller, IconData iconData,
      String text, bool tohide) {
    // Padding around the text field
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
      // Text field widget
      child: TextField(
        controller: controller, // Controller for text field
        obscureText: tohide, // Whether to obscure text (e.g., for passwords)
        style: const TextStyle(color: Colors.white), // Text style
        decoration: InputDecoration(
          hintText: text, // Placeholder text
          hintStyle: const TextStyle(color: Colors.grey), // Hint text style
          prefixIcon:
              Icon(iconData, color: Colors.white), // Icon before text field
          filled: true, // Whether to fill background
          fillColor: Colors.black, // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14), // Border radius
            borderSide: BorderSide.none, // No side border
          ),
        ),
      ),
    );
  }

  // Custom button widget
  static CustomButton(VoidCallback voidCallback, String text) {
    // Padding around the button
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      // Sized box to set button size
      child: SizedBox(
        height: 50, // Button height
        width: 300, // Button width
        // Elevated button widget
        child: ElevatedButton(
          onPressed: () {
            voidCallback(); // Callback function when button is pressed
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), // Button shape
            ),
            backgroundColor: const Color(0xFF17203A), // Button background color
            elevation: 4, // Button elevation
            shadowColor: Colors.black87, // Button shadow color
          ),
          // Button text
          child: Text(
            text, // Button text
            style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 20, // Text size
                fontWeight: FontWeight.w500), // Text weight
          ),
        ),
      ),
    );
  }

  // Custom alert dialog widget
  static CustomAlertBox(BuildContext context, String text) async {
    return showDialog(
      context: context, // Build context
      builder: (context) {
        // Backdrop filter for blurring background
        return BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 10, sigmaY: 10), // Blur effect parameters
          // Alert dialog widget
          child: AlertDialog(
            title: Text(text), // Alert dialog title
            content: const Text(
                'Oops! It looks like there was an error. Please check your information and try again.'), // Alert dialog content
            actions: <Widget>[
              // Button to dismiss dialog
              TextButton(
                child: const Text(
                  'OK', // Button text
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
