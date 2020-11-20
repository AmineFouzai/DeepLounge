import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _selectedScreen;

  @override
  void initState() {
    _selectedScreen = [
      Text(
        "Home",
        style: TextStyle(fontFamily: "Italianno"),
      ),
      Text(
        "Map",
        style: TextStyle(fontFamily: "Italianno"),
      ),
      Text(
        "Favorite",
        style: TextStyle(fontFamily: "Italianno"),
      ),
      Text(
        "Settings",
        style: TextStyle(fontFamily: "Italianno"),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          backgroundColor: Colors.green[400],
          title: Container(
            padding: EdgeInsets.only(left: 40, bottom: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.emoji_food_beverage,
                  size: 50,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Deep Lounge",
                    style: TextStyle(fontSize: 50, fontFamily: "Italianno"),
                  ),
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        ),
        body: Center(child: _selectedScreen[_selectedIndex]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.amber[400],
          child: BottomNavigationBar(
            selectedItemColor: Colors.orangeAccent[100],
            selectedLabelStyle: TextStyle(fontFamily: "Italianno"),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                  backgroundColor: Colors.green[400]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: "Map",
                  backgroundColor: Colors.green[400]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorite",
                  backgroundColor: Colors.green[400]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_applications),
                  label: "Settings",
                  backgroundColor: Colors.green[400]),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
