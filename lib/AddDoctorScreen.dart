import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDoctorScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: specializationController,
              decoration: InputDecoration(labelText: 'Specialization'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call a function to add the doctor to Firestore
                addDoctor();
                // Clear the text fields after adding the doctor
                nameController.clear();
                specializationController.clear();
              },
              child: Text('Add Doctor'),
            ),
          ],
        ),
      ),
    );
  }

  void addDoctor() {
    // Get a reference to the Firestore collection
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('Cardiologist');

    // Add a new document to the doctors collection
    doctors.add({
      'name': nameController.text,
      'specialization': specializationController.text,
    }).then((value) {
      print('Doctor added with ID: ${value.id}');
    }).catchError((error) {
      print('Failed to add doctor: $error');
    });
  }
}
