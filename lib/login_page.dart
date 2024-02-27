// Import necessary packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/UIhelper.dart'; // Custom UI helper class
import 'package:app/signuppage.dart'; // Page for signing up
import 'package:app/HomeView.dart'; // Home view after login

// Define a stateful widget for the login page
class LoginPage extends StatefulWidget {
  // Constructor to receive username as a parameter
  const LoginPage({Key? key, required this.userName}) : super(key: key);

  // Property to hold the username
  final String userName;

  // Create state for the widget
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// State class for the login page
class _LoginPageState extends State<LoginPage> {
  // Text editing controllers for email and password fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Async function to handle login process
  Future<void> Login(String email, String password) async {
    // Check if email and password are not empty
    if (email == "" && password == "") {
      // Show alert if required fields are not entered
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      try {
        // Sign in with email and password using Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        // Get username from user credentials, if available
        String userName = userCredential.user?.displayName ?? "";
        // Navigate to home view after successful login
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeView(
                      userName: userName,
                    )));
      } on FirebaseAuthException catch (ex) {
        // Handle Firebase authentication exceptions
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  // Build method to create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"), // App bar title
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom text field for email input
          UiHelper.CustomTextfield(emailController, Icons.mail, "Email", false),
          // Custom text field for password input
          UiHelper.CustomTextfield(
              passwordController, Icons.lock, "Password", true),
          const SizedBox(
            height: 10,
          ),
          // Custom button for login action
          UiHelper.CustomButton(() {
            Login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Log In"),
          const SizedBox(
            height: 20,
          ),
          // Text and button for navigating to sign up page
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                  onPressed: () {
                    // Navigate to sign up page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
