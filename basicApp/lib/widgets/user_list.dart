import 'package:basic_app/screens/chart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  List<Widget> makeListWidget(BuildContext context, AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((doc) {
      //print(doc.documentID);
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChartScreen(userId: doc.documentID)));
        },
        child: Container(
          height: 70.0,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.cyan),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Text(doc["name"]),
              leading: Image.network(
                doc["imgUrl"].toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
