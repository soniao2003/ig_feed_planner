import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HogeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // <1> Use FutureBuilder
    return FutureBuilder<QuerySnapshot>(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the data is being fetched
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that might occur
            return Center(child: Text('Its Error!'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            // Handle the case when snapshot has no data
            return Center(child: Text('No data available'));
          } else {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                          child: ListTile(
                            title: Text(doc['username']),
                            subtitle: Text(doc['email']),
                          ),
                        ))
                    .toList());
          }
        });
  }
}
