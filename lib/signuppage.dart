//signup page
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/UIhelper.dart';
import 'package:app/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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

  void _signUP(String email, String password, String name) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else if (!_isPasswordValid(password)) {
      String requirements = _getPasswordRequirements();
      UiHelper.CustomAlertBox(
          context, "Password requirements not met:\n\n$requirements");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await userCredential.user?.updateDisplayName(name);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              userName: name,
            ),
          ),
        );
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextfield(nameController, Icons.person, "Name", false),
          UiHelper.CustomTextfield(emailController, Icons.mail, "Email", false),
          UiHelper.CustomTextfield(
              passwordController, Icons.lock, "Password", true),
          SizedBox(height: 10),
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
