import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrList extends StatelessWidget {
  final String category;

  const DrList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Doctors'),
      ),
      body: Container(
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
                  return ListTile(
                    title: Text(doctorName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Specialties: $specialties'),
                        Text('Degrees: $degrees'),
                        Text('Location: $location'),
                        Text('Visiting Hour: $visitingHour'),
                        Text('Practice Days: $practiceDays'),
                      ],
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
