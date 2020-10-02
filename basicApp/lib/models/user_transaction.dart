import 'package:flutter/cupertino.dart';

class UserTransaction {
  final String transactionMonth;
  final double transactionCount;

  UserTransaction({
    @required this.transactionMonth,
    @required this.transactionCount,
  });
}