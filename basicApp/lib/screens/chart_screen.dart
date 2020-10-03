import 'package:basic_app/models/user_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartScreen extends StatelessWidget {
  final String userId;

  ChartScreen({Key key, this.userId}) : super(key: key);

  // final List<UserTransaction> userTransData = [
  //   UserTransaction(transactionMonth: "Jan", transactionCount: 10),
  //   UserTransaction(transactionMonth: "Feb", transactionCount: 20),
  //   UserTransaction(transactionMonth: "Mar", transactionCount: 30),
  //   UserTransaction(transactionMonth: "April", transactionCount: 40),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple bar Chart'),
      ),
      body: Chart(data: userTransData, userId: userId),
    );
  }
}

class Chart extends StatelessWidget {
  final List<UserTransaction> data;
  final String userId;

  Chart({@required this.data, @required this.userId});

  List<charts.Series<UserTransaction, String>> _seriesBardata;
  List<UserTransaction> _myData;

  _generate(_myData) {
    _seriesBardata.add(
      charts.Series(
        domainFn: (UserTransaction userTrans, _) => userTrans.transactionMonth.toString(),
        measureFn: (UserTransaction userTrans,_) => userTrans.transactionCount,
        id: 'UserTransactions',
        data: _myData
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    print(userId);

    return Scaffold()
    // List<charts.Series<UserTransaction, String>> _seriesData = [
    //   charts.Series(
    //     id: 'UsersTransactions',
    //     data: data,
    //     domainFn: (UserTransaction userTransaction, _) =>
    //         userTransaction.transactionMonth,
    //     measureFn: (UserTransaction userTransaction, _) =>
    //         userTransaction.transactionCount,
    //     colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
    //   )
    // ];

    // List<charts.Series<UserTransaction, String>> _buildData(AsyncSnapshot snapshot) {
    //   return snapshot.data.documents.map<Widget>((doc) {
    //     print(doc.data);
    //     List<charts.Series<UserTransaction, String>> _seriesData = [
    //       charts.Series(
    //         id: 'UsersTransactions',
    //         data: data,
    //         domainFn: (UserTransaction userTransaction, _) =>
    //             userTransaction.transactionMonth,
    //         measureFn: (UserTransaction userTransaction, _) =>
    //             userTransaction.transactionCount,
    //         colorFn: (__, _) =>
    //             charts.ColorUtil.fromDartColor(Color(0xff990099)),
    //       )
    //     ];
    //     return charts.BarChart(
    //     _seriesData,
    //     animate: true,
    //   );
    //   }).toList();

      // return charts.BarChart(
      //   _seriesData,
      //   animate: true,
      // );
    }

    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('bankUsers')
    //         .doc(userId)
    //         .collection('transactions')
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       return Padding(
    //         padding: const EdgeInsets.all(20.0),
    //         //child: _buildData(snapshot),
    //         child: charts.BarChart(
    //           _buildData(snapshot),
    //           animate: true,
    //         ),
    //       );
    //     });
  }

