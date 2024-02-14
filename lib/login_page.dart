import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/UIhelper.dart';
import 'package:app/signuppage.dart';
import 'package:app/HomeView.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.userName}) : super(key: key);
  final String userName;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> Login(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        String userName = userCredential.user?.displayName ?? "";
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeView(
                      userName: userName,
                    )));
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextfield(emailController, Icons.mail, "Email", false),
          UiHelper.CustomTextfield(
              passwordController, Icons.lock, "Password", true),
          const SizedBox(
            height: 10,
          ),
          UiHelper.CustomButton(() {
            Login(emailController.text.toString(),
                passwordController.text.toString());
          }, "Log In"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignupPage()));
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
