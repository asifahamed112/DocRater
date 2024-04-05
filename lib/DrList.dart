import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DoctorListItem extends StatelessWidget {
  final DocumentSnapshot doc;
  final String searchQuery;

  const DoctorListItem(this.doc, this.searchQuery, {Key? key})
      : super(key: key);

  TextSpan _highlightText(String text) {
    if (searchQuery.isEmpty) {
      return TextSpan(text: text);
    }
    final List<TextSpan> spans = [];
    int lastIndex = 0;
    final lowercaseText = text.toLowerCase();
    final lowercaseQuery = searchQuery.toLowerCase();

    for (int i = lowercaseText.indexOf(lowercaseQuery);
        i != -1;
        i = lowercaseText.indexOf(lowercaseQuery, i + 1)) {
      if (i > lastIndex) {
        spans.add(TextSpan(
            text: text.substring(lastIndex, i),
            style: TextStyle(color: Colors.grey)));
      }
      final String match = text.substring(i, i + lowercaseQuery.length);
      spans.add(
          TextSpan(text: match, style: TextStyle(color: Colors.limeAccent)));
      lastIndex = i + lowercaseQuery.length;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(color: Colors.grey)));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = doc['name'] ?? 'No Name';
    final degrees = doc['degrees'] ?? 'No Degrees';
    final location = doc['location'] ?? 'No Location';
    final practiceDays = doc['practiceDays'] ?? 'No Practice Days';
    final specialties = doc['specialties'] ?? 'No Specialties';
    final visitingHour = doc['visitingHour'] ?? 'No Visiting Hour';
    final number = doc['number'] ?? 'No Number';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      margin: EdgeInsets.all(15),
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text.rich(
            _highlightText(doctorName),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 3, color: Colors.white),
          Row(children: [
            Icon(Icons.school, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text.rich(
              _highlightText('Specialties: $specialties'),
              style: TextStyle(
                color: Colors.grey,
              ),
            ))
          ]),
          Row(children: [
            Icon(Icons.work, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text.rich(
              _highlightText('Degrees: $degrees'),
              style: TextStyle(
                color: Colors.grey,
              ),
            ))
          ]),
          Row(children: [
            Icon(Icons.access_time, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text.rich(
              _highlightText('Visiting Hour: $visitingHour'),
              style: TextStyle(
                color: Colors.grey,
              ),
            ))
          ]),
          Row(children: [
            Icon(Icons.calendar_today, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text.rich(
              _highlightText('Practice Days: $practiceDays'),
              style: TextStyle(
                color: Colors.grey,
              ),
            ))
          ]),
          Row(children: [
            Icon(Icons.location_on, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
                child: Text.rich(
              _highlightText('Location: $location'),
              style: TextStyle(
                color: Colors.grey,
              ),
            ))
          ]),
          Row(children: [
            // Add this row
            Icon(Icons.phone, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: number));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Number copied to clipboard'),
                    ),
                  );
                },
                child: Text.rich(
                  _highlightText(number),
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}

class DrList extends StatefulWidget {
  final String category;

  const DrList({Key? key, required this.category}) : super(key: key);

  @override
  _DrListState createState() => _DrListState();
}

String searchQuery = '';

class _DrListState extends State<DrList> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${widget.category} Doctors'),
      ),
      body: Column(
        children: [
          Opacity(opacity: .1),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 34),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.35),
                      spreadRadius: 7,
                      blurRadius: 20,
                      blurStyle: BlurStyle.normal,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Docror . . . .',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              )),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(widget.category)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  var sortedDocs = snapshot.data!.docs.toList();
                  sortedDocs.sort((a, b) {
                    String degreesA = a['degrees'] ?? '';
                    String degreesB = b['degrees'] ?? '';
                    return degreesB
                        .split(',')
                        .length
                        .compareTo(degreesA.split(',').length);
                  });

                  sortedDocs = sortedDocs.where((doc) {
                    String name = doc['name']?.toLowerCase() ?? '';
                    String specialties =
                        doc['specialties']?.toLowerCase() ?? '';
                    String location = doc['location']?.toLowerCase() ?? '';
                    String degrees = doc['degrees']?.toLowerCase() ?? '';
                    String practiceDays =
                        doc['practiceDays']?.toLowerCase() ?? '';
                    String visitingHour =
                        doc['visitingHour']?.toLowerCase() ?? '';

                    return name.contains(searchQuery) ||
                        specialties.contains(searchQuery) ||
                        location.contains(searchQuery) ||
                        degrees.contains(searchQuery) ||
                        practiceDays.contains(searchQuery) ||
                        visitingHour.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: sortedDocs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = sortedDocs[index];
                      return DoctorListItem(document, searchQuery);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
