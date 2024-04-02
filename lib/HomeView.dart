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
  List<Map<String, String>> filteredCategories = [];

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
    {
      "name": "Sonologist",
      "imageUrl":
          "https://i.pinimg.com/originals/27/af/a3/27afa3595576c0dd6af0319e24463838.jpg"
    },
    // Add more categories as needed
  ];

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ${widget.userName}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Find your specialist",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 34),
                height: 45,
                width: double.infinity,
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
                  onChanged: (value) {
                    setState(() {
                      filteredCategories = categories
                          .where((category) => category["name"]!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Category . . . .',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return CatBlock(
                  name: filteredCategories[index]["name"]!,
                  imageUrl: filteredCategories[index]["imageUrl"]!,
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDoctorScreen()),
                  );
                },
                icon: Icon(Icons.add),
                label: Text("Add Doctor"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
