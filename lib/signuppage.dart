import 'package:app/UIhelper.dart';
import 'package:app/login_page.dart';
import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   signUP(String email,String password)async{
     if(email=="" && password=="")
       {
         UiHelper.CustomAlertBox(context, "Enter Required Fields");
       }
     else
       {
         UserCredential?  usercredential;
         try{
           usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
           });
         }
         on FirebaseAuthException catch(ex)
     {
       return UiHelper.CustomAlertBox( context,ex.code.toString()); 
     }
       }
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
        UiHelper.CustomTextfield(emailController, Icons.mail, "Email", false),
        UiHelper.CustomTextfield(passwordController, Icons.lock ,"Password",true),
        SizedBox(height: 10,),
        UiHelper.CustomButton(() {
          signUP(emailController.text.toString(), passwordController.text.toString());
        }, "Register")
      ],),
    );
  }
}


