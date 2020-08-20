import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingCart/blocs/bloc/products_bloc.dart';
import 'package:shoppingCart/widgets/all_pdts.dart';
import 'package:shoppingCart/widgets/category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(create: (_) => ProductsBloc()..add(ProductLoadedEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        theme: ThemeData(
          //https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
          //https://medium.com/flutter-community/simple-ways-to-pass-to-and-share-data-with-widgets-pages-f8988534bd5b

          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => MyHomePage(title: 'Shopping Cart'),
          //'/cart': (context) => MyCart(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.only(right: 20.0),
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () {}),
        ],
      ),
      drawer: Drawer(),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 10,
          ),
          Category(),
          Center(
              child: Text(
            'Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          AllProducts()
        ],
      ),
    );
  }
}
