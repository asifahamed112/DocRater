import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> categories = [
  "Cardiology",
  "Chest Medicine",
  "Consult Sonologist",
  "Consultant Pathologist",
  "Sonologist",
  "Skin / Dermatology",
  "Diabetologist",
  "Dietician",
  "Endocrine Medicine",
  "Endocrinology",
  "ENT, Head & Neck Surgery",
  "Eye / Ophthalmology",
  "Gastroenterology",
  "Neurosurgery",
  "General Surgery",
  "Haematology",
  "Liver Medicine/Hepatology",
  "Liver, Biliary And Pancreatic Surgery",
  "Medicine",
  "Medicine And Neurology Specialist",
  "Neurology",
  "Gynaecology",
  "Orthopaedic Surgery",
  "Pain Management",
  "Pathologist",
  "Child/Pediatric",
  "Pediatric Surgery",
  "Physical Medicine And Rehabilitation",
  "Physiotherapy Department",
  "Psychiatry",
  "Radiologist & Sonologist",
  "Radiology & Imaging",
  "Respiratory Medicine",
  "Rheumatology Medicine",
  "Urology Surgery",
  "Nephrology / Kidney Medicine",
  "Urologist",
  "Hepatology",
  "Child Neurology",
  "Nuclear Medicine",
  "Child Paediatrics",
  "General and Colo-Rectal Surgeon",
  "Orthopedics",
  "Colorectal Surgery",
  "Paediatrics Surgery",
  "Plastic Surgery",
  "Vascular Surgery",
  "Oncology",
  "Breast, Colorectal & Laparoscopy Surgery",
  "Lithotripsy Department",
  "Medical Officer",
  "Spine, Orthopaedic & Trauma Surgeon",
  "Hematology Specialist",
  "Medicine and Diabetologist",
  "Nutritionist",
  "General Surgeon",
  "Clinical & Interventional Cardiologist",
  "Neuro Medicine",
  "Child Specialist & Neonatologist",
  "Urology",
  "General Physician",
  "Colorectal, Laparoscopy & Breast Surgeon",
];

class AddDoctorScreen extends StatefulWidget {
  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController degreesController = TextEditingController();
  final TextEditingController practiceDaysController = TextEditingController();
  final TextEditingController visitingHourController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController specialtiesController = TextEditingController();
  String selectedCategory = "Cardiology"; // Default category

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
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: degreesController,
              decoration: InputDecoration(labelText: 'Degrees'),
            ),
            TextField(
              controller: practiceDaysController,
              decoration: InputDecoration(labelText: 'Practice Days'),
            ),
            TextField(
              controller: visitingHourController,
              decoration: InputDecoration(labelText: 'Visiting Hour'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call a function to add the doctor to Firestore
                addDoctor();
                // Clear the text fields after adding the doctor
                nameController.clear();
                degreesController.clear();
                practiceDaysController.clear();
                visitingHourController.clear();
                locationController.clear();
                specialtiesController.clear();
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
        FirebaseFirestore.instance.collection(selectedCategory);

    // Add a new document to the doctors collection
    doctors.add({
      'category': selectedCategory,
      'name': nameController.text,
      'degrees': degreesController.text,
      'practiceDays': practiceDaysController.text,
      'visitingHour': visitingHourController.text,
      'location': locationController.text,
      'specialties': selectedCategory,
    }).then((value) {
      print('Doctor added with ID: ${value.id}');
    }).catchError((error) {
      print('Failed to add doctor: $error');
    });
  }
}
