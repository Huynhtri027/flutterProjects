import 'package:basic_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:basic_app/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class Basics extends StatelessWidget {
//   static const _title = "Basic App";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: HomePage(),
//     );
//   }
// }

// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

class HomePage extends StatefulWidget {
  final FirebaseAuthRepository _firebaseAuthRepository;
  final String name;

  HomePage(
      {Key key,
      @required this.name,
      @required FirebaseAuthRepository firebaseAuthRepository})
      : assert(firebaseAuthRepository != null),
        _firebaseAuthRepository = firebaseAuthRepository,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length,);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _tabList = [
    Container(
      color: Colors.white,
      child: UsersList(),
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.purple,
    )
  ];

  Widget getName () {
    return Tab(
      child: Text(widget.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Basics"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {
                //scaffoldKey.currentState.showSnackBar(snackBar);
              }),
          IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                openPage(context);
              }),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      //Center(child: Text('Welcome ${widget.name}')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedOut());
        },
        label: Text('Log Out'),
        icon: Icon(Icons.thumb_up),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });

          _tabController.animateTo(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Files", icon: Icon(Icons.folder)),
          BottomNavigationBarItem(label: "Settings", icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Page"),
      ),
      body:
          const Center(child: Text('New Page', style: TextStyle(fontSize: 22))),
    );
  }));
}
