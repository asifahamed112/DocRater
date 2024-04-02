// Import necessary packages
import 'package:app/login_page.dart'; // Importing the LoginPage widget
import 'package:firebase_core/firebase_core.dart'; // Importing Firebase Core package
import 'package:flutter/material.dart';

// Main function, entry point of the app
Future<void> main() async {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase app
  await Firebase.initializeApp();
  // Run the app
  runApp(const MyApp());
}

// MyApp widget, the root of the application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Constructor for MyApp

  // Build method to create the UI for the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp widget for setting up the app
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: Builder(
        // Builder widget to access context
        builder: (context) => const LoginPage(
          // Creating an instance of LoginPage widget with a default username
          userName: "your_default_user_name",
        ),
      ),
    );
  }
}
