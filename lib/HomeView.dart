// Import necessary packages
import 'package:flutter/material.dart'; // Flutter material library for UI components
import 'package:app/CatBlock.dart'; // Custom category block widget
import 'package:app/AddDoctorScreen.dart'; // Screen to add a doctor
import 'package:app/DrList.dart'; // Import DrList widget for navigating to doctor list

// HomeView class, a StatefulWidget for the home screen
class HomeView extends StatefulWidget {
  final String userName; // Username passed from the previous screen

  // Constructor for HomeView widget
  const HomeView({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState(); // Create state for HomeView
}

// State class for the home screen
class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController =
      TextEditingController(); // Controller for search field

  // Define categories with name and image URL
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
        // App bar configuration
        toolbarHeight: 100, // App bar height
        titleSpacing: 50, // Spacing between title and edge of the screen
        elevation: 0, // No elevation
        backgroundColor: Colors.transparent, // Transparent background
        title: Column(
          // Column for app bar title and subtitle
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User greeting
            Text(
              "Hello ${widget.userName}", // Display username
              style: TextStyle(fontSize: 20, color: Colors.black), // Text style
            ),
            SizedBox(
              height: 0, // Spacer between greeting and subtitle
            ),
            // App subtitle
            Text(
              "Find your specialist", // Subtitle text
              style: TextStyle(
                fontSize: 30, // Subtitle text size
                color: Colors.black, // Subtitle text color
                fontWeight: FontWeight.bold, // Subtitle text weight
              ),
            )
          ],
        ),
        automaticallyImplyLeading:
            false, // Do not automatically include leading icon/button
      ),
      body: Column(
        // Column for main content
        children: [
          // Search field container
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 100), // Margin around search field
            padding: EdgeInsets.symmetric(
                horizontal: 34), // Padding within search field container
            child: Container(
              // Search field container
              height: 45, // Search field height
              width: 250, // Search field width
              decoration: BoxDecoration(
                // Search field decoration
                borderRadius: BorderRadius.circular(100), // Border radius
                boxShadow: [
                  // Box shadow for search field
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3), // Shadow color
                    spreadRadius: 7, // Shadow spread radius
                    blurRadius: 20, // Shadow blur radius
                    blurStyle: BlurStyle.normal, // Shadow blur style
                    offset: Offset(0, 0), // Shadow offset
                  ),
                ],
              ),
              child: TextField(
                // Search text field
                controller: _searchController, // Controller for search field
                decoration: InputDecoration(
                  // Text field decoration
                  prefixIcon: Icon(Icons.search), // Search icon
                  hintText: 'Search Doctor . . . .', // Placeholder text
                  hintStyle:
                      TextStyle(color: Colors.grey), // Placeholder text style
                  border: InputBorder.none, // No border
                ),
              ),
            ),
          ),
          // Expanded container for category blocks
          Expanded(
            child: ListView.builder(
              // ListView builder for category blocks
              itemCount: (categories.length / 3).ceil(), // Number of rows
              itemBuilder: (context, rowIndex) {
                return Column(
                  // Column for each row of category blocks
                  children: [
                    Row(
                      // Row for category blocks
                      children: [
                        for (int i = rowIndex * 3;
                            i < (rowIndex * 3) + 3 && i < categories.length;
                            i++)
                          Expanded(
                            // Expanded widget to evenly distribute category blocks
                            child: CatBlock(
                              // Custom category block widget
                              name: categories[i]["name"]!, // Category name
                              imageUrl: categories[i]
                                  ["imageUrl"]!, // Category image URL
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 30), // Spacer between rows
                  ],
                );
              },
            ),
          ),
          // Button to add a doctor
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp), // Add doctor icon
            color: Colors.transparent, // Transparent color
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
