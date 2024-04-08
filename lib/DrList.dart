import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              _highlightText(doctorName),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Divider(thickness: 3, color: Colors.white),
            Row(
              children: [
                Icon(Icons.school, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    _highlightText('Specialties: $specialties'),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.work, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    _highlightText('Degrees: $degrees'),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    _highlightText('Visiting Hour: $visitingHour'),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    _highlightText('Practice Days: $practiceDays'),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    _highlightText('Location: $location'),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrListModel extends ChangeNotifier {
  List<DocumentSnapshot> _documents = [];
  List<DocumentSnapshot> get documents => _documents;

  Future<void> fetchDoctors(String category) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(category)
          .get()
          .catchError((error) => throw error);
      _documents = querySnapshot.docs;
      notifyListeners();
    } catch (e) {
      print('Error fetching doctors: $e');
    }
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
    return ChangeNotifierProvider<DrListModel>(
        create: (_) => DrListModel(),
        child: Scaffold(
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
                child: Consumer<DrListModel>(builder: (context, model, child) {
                  if (model.documents.isEmpty) {
                    model.fetchDoctors(widget.category);
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      strokeWidth: 2,
                    ));
                  }
                  var sortedDocs = model.documents.toList();
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
                  if (sortedDocs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Doctor Found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return ListWheelScrollView.useDelegate(
                    itemExtent: 350, // Adjust the height of each item as needed
                    diameterRatio: 4,
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: sortedDocs.length,
                      builder: (context, index) {
                        DocumentSnapshot document = sortedDocs[index];
                        return DoctorListItem(document, searchQuery);
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
