import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

List<String> categories = [
  "Cardiology",
  "Chest Medicine",
  "Consult Sonologist",
  "Consultant Pathologist",
  "Sonologist",
  "Skin or Dermatology",
  "Diabetologist",
  "Dietician",
  "Endocrine Medicine",
  "Endocrinology",
  "ENT, Head & Neck Surgery",
  "Eye or Ophthalmology",
  "Gastroenterology",
  "Neurosurgery",
  "General Surgery",
  "Haematology",
  "Liver Medicine or Hepatology",
  "Liver, Biliary And Pancreatic Surgery",
  "Medicine",
  "Medicine And Neurology Specialist",
  "Neurology",
  "Gynaecology",
  "Orthopaedic Surgery",
  "Pain Management",
  "Pathologist",
  "Child or Pediatric",
  "Pediatric Surgery",
  "Physical Medicine And Rehabilitation",
  "Physiotherapy Department",
  "Psychiatry",
  "Radiologist & Sonologist",
  "Radiology & Imaging",
  "Respiratory Medicine",
  "Rheumatology Medicine",
  "Urology Surgery",
  "Nephrology or Kidney Medicine",
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
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _degreesController = TextEditingController();
  final TextEditingController _practiceDaysController = TextEditingController();
  final TextEditingController _visitingHourController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _selectedCategory = categories.first;
  String _errorMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _degreesController.dispose();
    _practiceDaysController.dispose();
    _visitingHourController.dispose();
    _locationController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _degreesController,
              decoration: const InputDecoration(labelText: 'Degrees'),
            ),
            TextField(
              controller: _practiceDaysController,
              decoration: const InputDecoration(labelText: 'Practice Days'),
            ),
            TextField(
              controller: _visitingHourController,
              decoration: const InputDecoration(labelText: 'Visiting Hour'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addDoctor, // Changed this line
              child: const Text('Add Doctor'),
            ),
          ],
        ),
      ),
    );
  }

  bool _canAddDoctor() {
    return _nameController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _degreesController.text.isNotEmpty &&
        _practiceDaysController.text.isNotEmpty &&
        _visitingHourController.text.isNotEmpty &&
        _locationController.text.isNotEmpty;
  }

  Future<void> _addDoctor() async {
    if (_canAddDoctor()) {
      final CollectionReference doctors =
          FirebaseFirestore.instance.collection(_selectedCategory);

      final QuerySnapshot existingDocs = await doctors
          .where('name', isEqualTo: _nameController.text)
          .where('degrees', isEqualTo: _degreesController.text)
          .where('location', isEqualTo: _locationController.text)
          .get();

      if (existingDocs.docs.isNotEmpty) {
        _showErrorMessage(
            'A doctor with the same name, degree, and location already exists.');
      } else {
        await doctors.add({
          'name': _nameController.text,
          'degrees': _degreesController.text,
          'practiceDays': _practiceDaysController.text,
          'visitingHour': _visitingHourController.text,
          'location': _locationController.text,
          'number': _numberController.text,
          'specialties': _selectedCategory,
        });
        _clearFields();
      }
    } else {
      _showErrorMessage('Please fill in all required fields.');
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  void _clearFields() {
    _nameController.clear();
    _degreesController.clear();
    _practiceDaysController.clear();
    _visitingHourController.clear();
    _locationController.clear();
    _numberController.clear();
    setState(() {
      _errorMessage = '';
    });
  }
}
