import 'package:basic_app/screens/chart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  List<Widget> makeListWidget(BuildContext context, AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((doc) {
      print(doc.documentID);
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChartScreen(userId: doc.documentID)));
        },
        child: ListTile(
          title: Text(doc["name"]),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('bankUsers').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                default:
                  return ListView(
                    children: makeListWidget(context, snapshot),
                  );
              }
            }));
  }
}
