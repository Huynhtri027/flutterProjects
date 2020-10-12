import 'package:basic_app/models/user_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class ChartScreen extends StatelessWidget {
  final String userId;

  List<charts.Series<UserTransaction, String>> _seriesBardata;
  List<UserTransaction> _myData;

  ChartScreen({Key key, this.userId}) : super(key: key);

  _generate(_myData) {
    _seriesBardata = [
      (charts.Series(
          domainFn: (UserTransaction userTrans, _) =>
              userTrans.transactionMonth.toString(),
          measureFn: (UserTransaction userTrans, _) =>
              userTrans.transactionCount,
          id: 'UserTransactions',
          data: _myData))
    ];
  }

  Widget _buildBody(context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bankUsers')
            .doc(userId)
            .collection('transactions')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            List<UserTransaction> userTrans = snapshot.data.docs
                .map((docSnapshot) =>
                    UserTransaction.fromMap(docSnapshot.data()))
                .toList();
            return _buildChart(context, userTrans);
          }
        });
  }

  Widget _buildChart(BuildContext context, List<UserTransaction> userTrans) {
    _myData = userTrans;
    _generate(_myData);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Center(
                  child: Text(
                'Transactions by Month',
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
              SizedBox(height: 20.0),
              Expanded(
                child: charts.BarChart(
                  _seriesBardata,
                  animate: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple bar Chart'),
      ),
      body: _buildBody(context),
    );
  }
}
