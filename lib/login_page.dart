import 'package:app/HomeView.dart';
import 'package:app/UIhelper.dart';
import 'package:app/main.dart';
import 'package:app/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Login(String email,String password)async{
    if(email==""&&password=="")
    {
      return UiHelper.CustomAlertBox(context, "Enter Required Fields");
    }
    else
      {
        UserCredential? userCredential;
        try
            {
              userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView(userName: email)));
              } );
            }
            on FirebaseAuthException catch(ex)
    {
      return UiHelper.CustomAlertBox(context, ex.code.toString());
    }
      }
  }

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
        UiHelper.CustomTextfield(emailController,Icons.mail, "Email", false),
        UiHelper.CustomTextfield(passwordController, Icons.lock ,"Password",true),
        SizedBox(height: 10,),
        UiHelper.CustomButton(() {
          Login(emailController.text.toString(),passwordController.text.toString());
        }, "Log In"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?",style: TextStyle(fontSize: 15),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
              }, child: Text("Register",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),))
            ],
          )
      ],),
    );
  }
}
