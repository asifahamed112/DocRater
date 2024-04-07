import 'package:flutter/material.dart';
import 'package:app/CatBlock.dart';
import 'package:app/AddDoctorScreen.dart';

class HomeView extends StatefulWidget {
  final String userName;

  const HomeView({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredCategories = [];

  static const List<Map<String, String>> categories = [
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
      "name": "Consult Sonologist",
      "imageUrl":
          "https://i.pinimg.com/originals/11/05/58/110558ea504abcc25560d043deb7068f.png"
    },
    {
      "name": "Consultant Pathologist",
      "imageUrl":
          "https://i.pinimg.com/originals/7e/74/1d/7e741d44e5257b869e1c58094b5dfd97.png"
    },
    {
      "name": "Sonologist",
      "imageUrl":
          "https://i.pinimg.com/originals/b0/25/64/b025644bc1c6c32aa3849c84341272f8.png"
    },
    {
      "name": "Skin or Dermatology",
      "imageUrl":
          "https://i.pinimg.com/originals/e8/77/ff/e877ff2ae544dae0eb543e85b5c52745.png"
    },
    {
      "name": "Diabetologist",
      "imageUrl":
          "https://i.pinimg.com/originals/53/30/df/5330df39e1cce305f82fdddaa60c951a.png"
    },
    {
      "name": "Dietician",
      "imageUrl":
          "https://i.pinimg.com/originals/13/8a/c6/138ac67d487916a7278e19633a22b5ea.png"
    },
    {
      "name": "Endocrine Medicine",
      "imageUrl":
          "https://i.pinimg.com/originals/27/af/a3/27afa3595576c0dd6af0319e24463838.jpg"
    },
    {
      "name": "Endocrinology",
      "imageUrl":
          "https://i.pinimg.com/originals/8b/c1/80/8bc18099dd05caccbbf40d64d3a43994.png"
    },
    {
      "name": "ENT, Head & Neck Surgery",
      "imageUrl":
          "https://i.pinimg.com/originals/96/88/f4/9688f461f5126398e735c8d2b260a6c1.png"
    },
    {
      "name": "Eye or Ophthalmology",
      "imageUrl":
          "https://i.pinimg.com/originals/b3/89/8f/b3898ff2c1f632741ddf7f267c6092c9.png"
    },
    {
      "name": "Gastroenterology",
      "imageUrl":
          "https://i.pinimg.com/originals/6e/2f/91/6e2f919d6dd8354f6e1e5e93e553bb33.png"
    },
    {
      "name": "Neurology",
      "imageUrl":
          "https://i.pinimg.com/originals/2d/fe/09/2dfe0902c68d266452fbb2c792f27259.png"
    },
    {
      "name": "General Surgery",
      "imageUrl":
          "https://i.pinimg.com/originals/69/a5/e8/69a5e8d292aba2df65932b64a6a0bb01.png"
    },
    {
      "name": "Haematology",
      "imageUrl":
          "https://i.pinimg.com/originals/b1/5e/81/b15e810cf0f418cfd9c0bb80c4e517ff.png"
    },
    {
      "name": "Liver Medicine or Hepatology",
      "imageUrl":
          "https://i.pinimg.com/originals/43/4e/b6/434eb6a91d312c0893e7a894cd4401c4.png"
    },
    {
      "name": "Liver, Biliary And Pancreatic Surgery",
      "imageUrl":
          "https://i.pinimg.com/originals/cb/73/03/cb7303d735497f07c606a8fe56e2ec3c.png"
    },
    {
      "name": "Medicine",
      "imageUrl":
          "https://i.pinimg.com/originals/80/a2/66/80a266e088b40ad4a165e7b127e53e3a.png"
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
    super.build(context); // For AutomaticKeepAliveClientMixin
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildSearchField(),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 20,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return CatBlock(
                  name: filteredCategories[index]["name"]!,
                  imageUrl: filteredCategories[index]["imageUrl"]!,
                );
              },
            ),
          ),
          _buildAddDoctorButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search Category . . . .',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            childAspectRatio: 1.3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 20,
          ),
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            return CatBlock(
              name: filteredCategories[index]["name"]!,
              imageUrl: filteredCategories[index]["imageUrl"]!,
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddDoctorButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _navigateToAddDoctorScreen,
        icon: Icon(Icons.add),
        label: Text("Add Doctor"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      filteredCategories = categories
          .where((category) =>
              category["name"]!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _navigateToAddDoctorScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDoctorScreen()),
    );
  }

  @override
  bool get wantKeepAlive => true; // For AutomaticKeepAliveClientMixin
}
