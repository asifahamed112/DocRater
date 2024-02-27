// Import necessary packages
import 'package:flutter/material.dart'; // Flutter material library for UI components
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package for database operations

// Widget to display information of a single doctor
class DoctorListItem extends StatelessWidget {
  final DocumentSnapshot doc; // Pass the entire DocumentSnapshot as parameter

  // Constructor for DoctorListItem widget
  const DoctorListItem(this.doc, {Key? key}) : super(key: key);

  // Build method to create the UI for displaying doctor information
  @override
  Widget build(BuildContext context) {
    // Extracting doctor information from the document
    final doctorName = doc['name'] ?? 'No Name'; // Doctor name
    final degrees = doc['degrees'] ?? 'No Degrees'; // Doctor degrees
    final location = doc['location'] ?? 'No Location'; // Doctor location
    final practiceDays =
        doc['practiceDays'] ?? 'No Practice Days'; // Doctor practice days
    final specialties =
        doc['specialties'] ?? 'No Specialties'; // Doctor specialties
    final visitingHour =
        doc['visitingHour'] ?? 'No Visiting Hour'; // Doctor visiting hour

    // Return a card widget to display doctor information
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)), // Card shape
      elevation: 10, // Card elevation
      margin: EdgeInsets.all(15), // Card margin
      color: Colors.black87, // Set card color to black
      child: Padding(
        padding:
            const EdgeInsets.fromLTRB(16, 16, 16, 8), // Padding inside card
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Display doctor name
          Text(doctorName,
              style: TextStyle(
                fontWeight: FontWeight.bold, // Bold font weight
                fontSize: 18, // Font size
                color: Colors.white, // Set text color to white
              )),
          Divider(thickness: 3, color: Colors.white), // Divider line
          // Display doctor specialties
          Row(children: [
            Icon(Icons.school,
                size: 16, color: Colors.white), // Icon for specialties
            SizedBox(width: 8), // Spacer
            Expanded(
                child: Text(
                    'Specialties: $specialties', // Display doctor specialties
                    style: TextStyle(
                        color: Colors.grey))) // Set text color to grey
          ]),
          // Display doctor degrees
          Row(children: [
            Icon(Icons.work, size: 16, color: Colors.white), // Icon for degrees
            SizedBox(width: 8), // Spacer
            Expanded(
                child: Text('Degrees: $degrees', // Display doctor degrees
                    style: TextStyle(
                        color: Colors.grey))) // Set text color to grey
          ]),
          // Display doctor visiting hour
          Row(children: [
            Icon(Icons.access_time,
                size: 16, color: Colors.white), // Icon for visiting hour
            SizedBox(width: 8), // Spacer
            Expanded(
                child: Text(
                    'Visiting Hour: $visitingHour', // Display visiting hour
                    style: TextStyle(
                        color: Colors.grey))) // Set text color to grey
          ]),
          // Display doctor practice days
          Row(children: [
            Icon(Icons.calendar_today,
                size: 16, color: Colors.white), // Icon for practice days
            SizedBox(width: 8), // Spacer
            Expanded(
                child: Text(
                    'Practice Days: $practiceDays', // Display practice days
                    style: TextStyle(
                        color: Colors.grey))) // Set text color to grey
          ]),
          // Display doctor location
          Row(children: [
            Icon(Icons.location_on,
                size: 16, color: Colors.white), // Icon for location
            SizedBox(width: 8), // Spacer
            Expanded(
                child: Text('Location: $location', // Display location
                    style: TextStyle(
                        color: Colors.grey))) // Set text color to grey
          ])
        ]),
      ),
    );
  }
}

// Main widget to display a list of doctors for a specific category
class DrList extends StatefulWidget {
  final String category; // Category of doctors to display

  // Constructor for DrList widget
  const DrList({Key? key, required this.category}) : super(key: key);

  @override
  _DrListState createState() => _DrListState(); // Create state for DrList
}

// State class for DrList widget
class _DrListState extends State<DrList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar background
        title: Text(
            '${widget.category} Doctors'), // Display category name in app bar title
      ),
      body: StreamBuilder(
        // Stream builder to listen for changes in Firestore collection
        stream:
            FirebaseFirestore.instance.collection(widget.category).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Check connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
                    'No data available')); // Show message when no data available
          } else {
            return ListView.builder(
              // ListView builder to display list of doctors
              itemCount:
                  snapshot.data!.docs.length, // Number of items in the list
              itemBuilder: (context, index) {
                DocumentSnapshot document =
                    snapshot.data!.docs[index]; // Get document snapshot
                return DoctorListItem(
                    document); // Return DoctorListItem widget for each doctor
              },
            );
          }
        },
      ),
    );
  }
}
