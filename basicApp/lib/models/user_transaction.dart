import 'package:flutter/cupertino.dart';

class UserTransaction {
  final String transactionMonth;
  final int transactionCount;

  UserTransaction({
    @required this.transactionMonth,
    @required this.transactionCount,
  });

  UserTransaction.fromMap(Map<String, dynamic> map)
      : assert(map['count'] != null),
        assert(map['month'] != null),
        transactionCount = map['count'],
        transactionMonth = map['month'];

  @override
    String toString() => "Records<$transactionCount:$transactionMonth>";
}
