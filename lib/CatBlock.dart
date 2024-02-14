import 'package:flutter/material.dart';
import 'package:app/DrList.dart';

class CatBlock extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CatBlock({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrList(category: name),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl, // Use the imageUrl parameter
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 5,
              child: Text(
                name, // Use the name parameter
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
