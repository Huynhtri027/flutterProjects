import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 22.0),
                  decoration: InputDecoration(
                      hintText: 'Type Email',
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      contentPadding: EdgeInsets.all(5.0))),
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 22.0),
                  decoration: InputDecoration(
                      hintText: 'Type Password',
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      contentPadding: EdgeInsets.all(5.0))),
              SizedBox(
                height: 40.0,
              ),
              InkWell(
                onTap: () {},
                customBorder: Border.all(color: Colors.black),
                child: Container(
                  height: 30.0,
                  width: 160.0,
                  decoration:
                      BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
