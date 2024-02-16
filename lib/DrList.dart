import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrList extends StatelessWidget {
  final String category;

  const DrList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('$category Doctors'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://images.pexels.com/photos/4386467/pexels-photo-4386467.jpeg"), // Provide your image URL here
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(category).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  final doctorName = document.get('name') ?? 'No Name';
                  final degrees = document.get('degrees') ?? 'No Degrees';
                  final location = document.get('location') ?? 'No Location';
                  final practiceDays =
                      document.get('practiceDays') ?? 'No Practice Days';
                  final specialties =
                      document.get('specialties') ?? 'No Specialties';
                  final visitingHour =
                      document.get('visitingHour') ?? 'No Visiting Hour';
                  return SizedBox(
                    height: 230,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 0,
                        height: 0,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 2.0,
                                sigmaY: 2.0,
                              ),
                              child: Container(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.5)),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.1),
                                      Colors.white.withOpacity(0.1),
                                    ]),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      doctorName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black87,
                                          fontSize: 20),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Specialties: $specialties'),
                                        Text('Degrees: $degrees'),
                                        Text('Visiting Hour: $visitingHour'),
                                        Text('Practice Days: $practiceDays'),
                                        Text('Location: $location'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
