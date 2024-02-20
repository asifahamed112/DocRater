import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorListItem extends StatelessWidget {
  final DocumentSnapshot doc; // Pass the entire DocumentSnapshot as parameter

  const DoctorListItem(this.doc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctorName = doc['name'] ?? 'No Name';
    final degrees = doc['degrees'] ?? 'No Degrees';
    final location = doc['location'] ?? 'No Location';
    final practiceDays = doc['practiceDays'] ?? 'No Practice Days';
    final specialties = doc['specialties'] ?? 'No Specialties';
    final visitingHour = doc['visitingHour'] ?? 'No Visiting Hour';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      margin: EdgeInsets.all(15),
      color: Colors.black87, // Set card color to black
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(doctorName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white, // Set text color to white
              )),
          Divider(thickness: 3, color: Colors.white
              // Set divider color to white with opacity
              ),
          Row(children: [
            Icon(Icons.school, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text('Specialties: $specialties',
                    style: TextStyle(color: Colors.grey)))
          ]),
          Row(children: [
            Icon(Icons.work, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text('Degrees: $degrees',
                    style: TextStyle(color: Colors.grey)))
          ]),
          Row(children: [
            Icon(Icons.access_time, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text('Visiting Hour: $visitingHour',
                    style: TextStyle(color: Colors.grey)))
          ]),
          Row(children: [
            Icon(Icons.calendar_today, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text('Practice Days: $practiceDays',
                    style: TextStyle(color: Colors.grey)))
          ]),
          Row(children: [
            Icon(Icons.location_on, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text('Location: $location',
                    style: TextStyle(color: Colors.grey)))
          ])
        ]),
      ),
    );
  }
}

// Main widget
class DrList extends StatefulWidget {
  final String category;

  const DrList({Key? key, required this.category}) : super(key: key);

  @override
  _DrListState createState() => _DrListState();
}

class _DrListState extends State<DrList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${widget.category} Doctors'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(widget.category).snapshots(),
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
                return DoctorListItem(document);
              },
            );
          }
        },
      ),
    );
  }
}
