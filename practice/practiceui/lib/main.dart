import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool colorSwitch = false;

  @override
  Widget build(BuildContext context) {

    Widget raiseSnackBar(){
      return SnackBar(
        content: Text('orange moved '));
     }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Practice'),
      ),
      body: Container(
        child: Row(
          children: [
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Container(
                color: colorSwitch ? Colors.red : Colors.orange,
                
              ),
            ),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Container(
                color: colorSwitch ? Colors.orange : Colors.red,
              ),
            ),
          ],
        ),
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          colorSwitch = !colorSwitch ? true : false;
          print(colorSwitch);
          raiseSnackBar();
          //Scaffold.of(context).showSnackBar(raiseSnackBar());
          setState(() {
            colorSwitch = colorSwitch;
          });
        },
      ),
    );
  }
}