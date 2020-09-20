import 'package:flutter/material.dart';
import 'package:foodDeliveryUI/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Food Delivery App',
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.grey[50],
      primaryColor: Colors.deepOrangeAccent,
    ),
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),   
    );
  }
}
