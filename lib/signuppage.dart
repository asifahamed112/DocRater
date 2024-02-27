// Import necessary packages
import 'package:flutter/material.dart'; // Flutter material library for UI components
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'package:app/UIhelper.dart'; // Custom UI helper class
import 'package:app/login_page.dart'; // Login page widget

// Define a stateful widget for the sign-up page
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}); // Constructor for SignupPage widget
  @override
  State<SignupPage> createState() =>
      _SignupPageState(); // Create state for SignupPage
}

// State class for the sign-up page
class _SignupPageState extends State<SignupPage> {
  // Text editing controllers for email, password, and name fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // Function to get password requirements
  String _getPasswordRequirements() {
    String requirements = "";
    if (passwordController.text.length < 8) {
      requirements += "- Minimum 8 characters\n";
    }
    if (!RegExp(r'[A-Z]').hasMatch(passwordController.text)) {
      requirements += "- At least one uppercase letter\n";
    }
    if (!RegExp(r'[a-z]').hasMatch(passwordController.text)) {
      requirements += "- At least one lowercase letter\n";
    }
    if (!RegExp(r'[0-9]').hasMatch(passwordController.text)) {
      requirements += "- At least one digit\n";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(passwordController.text)) {
      requirements += "- At least one special character\n";
    }
    return requirements;
  }

  // Function to handle sign-up process
  void _signUP(String email, String password, String name) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      // Check if required fields are empty
      UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else if (!_isPasswordValid(password)) {
      // Check if password meets requirements
      String requirements = _getPasswordRequirements();
      UiHelper.CustomAlertBox(
          context, "Password requirements not met:\n\n$requirements");
    } else {
      try {
        // Create user with email and password using Firebase authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // Update user display name
        await userCredential.user?.updateDisplayName(name);
        // Navigate to login page after successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              userName: name,
            ),
          ),
        );
      } on FirebaseAuthException catch (ex) {
        // Handle Firebase authentication exceptions
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  // Function to check if password is valid
  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  // Build method to create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"), // App bar title
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom text field for name input
          UiHelper.CustomTextfield(nameController, Icons.person, "Name", false),
          // Custom text field for email input
          UiHelper.CustomTextfield(emailController, Icons.mail, "Email", false),
          // Custom text field for password input
          UiHelper.CustomTextfield(
              passwordController, Icons.lock, "Password", true),
          const SizedBox(height: 10),
          // Custom button for sign-up action
          UiHelper.CustomButton(() {
            _signUP(
                emailController.text.toString(),
                passwordController.text.toString(),
                nameController.text.toString());
          }, "Register")
        ],
      ),
    );
  }
}
