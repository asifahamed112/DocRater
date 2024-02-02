import 'package:flutter/material.dart';

// Define the extractNameFromEmail function outside of the HomeView class
String extractNameFromEmail(String userName) {
  // Split the email address by the "@" symbol
  List<String> parts = userName.split("@");

  // The name is the part before the "@" symbol
  String name = parts[0];
  if (name.isEmpty) return name;
  return name[0].toUpperCase() + name.substring(1);
}

class HomeView extends StatelessWidget {
  final String userName;

  const HomeView({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Call the extractNameFromEmail function to get the name
              Text(
                "Hello ${extractNameFromEmail(userName)}",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                "Find your specialist",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Padding(

          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center( // Wrap with Center widget
              child: Container(
                height: 45,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.25),
                        spreadRadius: 7,
                        blurRadius: 20,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          color: Colors.transparent,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search_rounded),
                            hintText: 'Search Doctor . . . .',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
