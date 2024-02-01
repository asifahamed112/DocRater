import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiHelper{
  static CustomTextfield(TextEditingController controller,String text,IconData iconData,bool tohide)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: tohide,
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
          )
        ),
      ),
    );
  }
  static CustomButton(VoidCallback voidCallback,String text){
    return SizedBox(height: 50,width: 300, child: ElevatedButton(onPressed:(){
      voidCallback();
    },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25)
    )), child: Text(text,style: TextStyle(color: Colors.blueAccent,fontSize: 20),)),);
  }
}