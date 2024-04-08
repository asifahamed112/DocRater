// Import necessary packages
import 'package:flutter/material.dart'; // Flutter material library for UI components
import 'package:app/DrList.dart'; // Import DrList widget for navigating to doctor list
import 'package:cached_network_image/cached_network_image.dart';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 110,
                width: 110,
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
                name,
                style: TextStyle(
                  color: Colors.transparent,
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
