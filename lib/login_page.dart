import 'package:app/UIhelper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextfield(emailController, "Email", Icons.mail, false),
        UiHelper.CustomTextfield(passwordController, "Password", Icons.password, true),
        SizedBox(height: 30,),
        UiHelper.CustomButton(() { }, "Login"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have ab Acccount?",style: TextStyle(fontSize: 20),),
              TextButton(onPressed: (){}, child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),))
            ],
          )
      ],),
    );
  }
}
