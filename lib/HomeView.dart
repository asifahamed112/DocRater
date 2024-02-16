import 'package:flutter/material.dart';
import 'package:app/CatBlock.dart';
import 'package:app/AddDoctorScreen.dart';

class HomeView extends StatefulWidget {
  final String userName;

  const HomeView({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  // Define your categories here
  final List<Map<String, String>> categories = [
    {
      "name": "Cardiology",
      "imageUrl":
          "https://i.pinimg.com/736x/bc/3e/ec/bc3eec881fe88ab75bec51793e8321de.jpg"
    },
    {
      "name": "Chest Medicine",
      "imageUrl":
          "https://i.pinimg.com/originals/89/be/ea/89beeab39adf062bdf5dffcd4a6b610f.jpg"
    },
    {
      "name": "Endocrine Medicine",
      "imageUrl":
          "https://i.pinimg.com/originals/27/af/a3/27afa3595576c0dd6af0319e24463838.jpg"
    },
    // Add more categories as needed
  ];

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
              "Hello ${widget.userName}",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 0,
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 100),
            padding: EdgeInsets.symmetric(horizontal: 34),
            child: Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    spreadRadius: 7,
                    blurRadius: 20,
                    blurStyle: BlurStyle.normal,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Doctor . . . .',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (categories.length / 3).ceil(),
              itemBuilder: (context, rowIndex) {
                return Column(
                  children: [
                    Row(
                      children: [
                        for (int i = rowIndex * 3;
                            i < (rowIndex * 3) + 3 && i < categories.length;
                            i++)
                          Expanded(
                            child: CatBlock(
                              name: categories[i]["name"]!,
                              imageUrl: categories[i]["imageUrl"]!,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 30), // Add spacing between rows
                  ],
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp),
            color: Colors.transparent,
            onPressed: () {
              // Navigate to the screen where you can add a doctor
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDoctorScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
