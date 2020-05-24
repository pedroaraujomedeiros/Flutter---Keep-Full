import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/widgets.dart';
import '../Models/models.dart';
import '../Blocs/blocs.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedTabIndex = 0;

  List<Widget> _appBarChildren = [];

  /// show GroceryItemPage in add mode
  void _showGroceryItemPage(){
    Navigator.of(context).push(MaterialPageRoute<GroceryItem>(
      builder: (_) {
        return BlocProvider<GroceryListBloc>.value(
            value: BlocProvider.of<GroceryListBloc>(context),
            child: GroceryItem(
                Grocery.newItem(), ActionGroceryItem.Add));
      },
    ));
  }


  void _openGroceryListTab() {
    setState(() {
      _selectedTabIndex = 1;
    });
  }

  /// Update _selectedTabIndex property
  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
            onPressed: _showGroceryItemPage,
          ),
        ],
      ),
      AppBar(
        title: Text("Groceries Nearby"),
        centerTitle: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarChildren[_selectedTabIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: FittedBox(
                  child: Text(
                    "${widget.user.toString()}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryTextTheme.caption.color,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (bCtx) => About()));
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: _selectedTabIndex < 2
            ? IndexedStack(
                index: _selectedTabIndex,
                children: [
                  HomeTab(_openGroceryListTab),
                  SingleChildScrollView(
                    child: BlocBuilder<GroceryListBloc, GroceryListState>(
                      builder: (_, state) {
                        return GroceryListTab();
                      },
                    ),
                  ),
                ],
              )
            : MapTab(),
      ),

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

      floatingActionButton: _selectedTabIndex != 1
          ? null
          : FloatingActionButton(
              onPressed: _showGroceryItemPage,
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
    );
  }
}
