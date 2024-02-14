import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrList extends StatelessWidget {
  final String category;

  const DrList({Key? key, required this.category}) : super(key: key);

  // Inside the DrList widget's build method
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
              print('No data available for category: $category'); // Debug print
              return Center(child: Text('No data available'));
            } else {
              print('Category: $category'); // Debug print
              print(
                  'Number of documents: ${snapshot.data!.docs.length}'); // Debug print
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  print('Document data: ${document.data()}'); // Debug print
                  final doctorName = document.get('name');
                  return ListTile(
                    title: Text(doctorName ?? 'No Name'),
                    subtitle:
                        Text(document['specialization'] ?? 'No Specialization'),
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
