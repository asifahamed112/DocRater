// HomeView
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final String userName;

  const HomeView({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        titleSpacing: 50,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello $userName",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              "Find your specialist",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
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
            ],
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
    );
  }
}
