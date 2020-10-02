import 'package:basic_app/models/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartScreen extends StatelessWidget {
  final String userId;

  ChartScreen({Key key, this.userId}) : super(key: key);

  final List<UserTransaction> userTransData = [
    UserTransaction(transactionMonth: "Jan", transactionCount: 10),
    UserTransaction(transactionMonth: "Feb", transactionCount: 20),
    UserTransaction(transactionMonth: "Mar", transactionCount: 30),
    UserTransaction(transactionMonth: "April", transactionCount: 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple bar Chart'),
      ),
      body: Chart(data: userTransData),
    );
  }
}

class Chart extends StatelessWidget {
  final List<UserTransaction> data;

  Chart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<UserTransaction, String>> _seriesData = [
      charts.Series(
        id: 'UsersTransactions',
        data: data,
        domainFn: (UserTransaction userTransaction, _) =>
            userTransaction.transactionMonth,
        measureFn: (UserTransaction userTransaction, _) =>
            userTransaction.transactionCount,
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      )
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: charts.BarChart(
        _seriesData,
        animate: true,
      ),
    );
  }
}
