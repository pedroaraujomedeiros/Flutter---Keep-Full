import 'package:flutter/material.dart';
import './Widgets/HomeTab.dart';
import './Widgets/GroceryListTab.dart';
import './Widgets/MapTab.dart';
import './Models/AppKeepFull.dart';
import './Models/Grocery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Full',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: App.primarySwatch,
        iconTheme: IconThemeData(color: Color.fromRGBO(230, 74, 19, 1)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Keep Full'),
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
  int _selectedTabIndex = 0;
  final List<Grocery> _groceries = [];

  List<Widget> _appBarChildren = [];


  void _showGroceryItemModal(BuildContext ctx, Grocery grocery){

  }



  void _openGroceryListTab(){
    setState(() {
      _selectedTabIndex = 1;
    });
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    this._appBarChildren = [
      AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      AppBar(
        title: Text("Grocery List"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=> _showGroceryItemModal(context, Grocery.newItem()),
          ),
        ],
      ),
      AppBar(
        title: Text("Groceries Nearby"),
        centerTitle: true,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBarChildren[_selectedTabIndex],
      body: _selectedTabIndex < 2 ? IndexedStack(
        index: _selectedTabIndex,
        children:
        [
          HomeTab(_groceries,_openGroceryListTab),
          SingleChildScrollView(child: GroceryListTab()),
        ],
      ):MapTab()
      ,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Stores'),
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onBottomNavBarItemTapped,
        elevation: 5,
      ),
      floatingActionButton:
        _selectedTabIndex != 1
            ? null
            : FloatingActionButton(
                onPressed: ()=> _showGroceryItemModal(context, Grocery.newItem()),
                child: Icon(Icons.add,),
                backgroundColor: Theme.of(context).primaryColor,
              ),
    );
  }
}
