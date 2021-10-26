import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // This keeps track of which tab is currently selected. The selected index is the state being tracked by `_HomeState`. The underscore `_` signifies it's private.
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    // TODO: Replace with Card1
    Container(color: Colors.red),
    // TODO: Replace with Card2
    Container(color: Colors.green),
    // TODO: Replace with Card3
    Container(color: Colors.blue),
  ];

  // Handle tapped tab bar items by setting the index of the item that the user pressed.
  // `setState()` notifies the framework that the state of this object has changed, then rebuilds the widget internally.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          // Return the nearest `Theme` in the widget tree. If the widget has a defined `Theme`, it returns that. Otherwise it returns the app's theme.
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          // Tell the bottom navigation bar which tab bar item to highlight
          currentIndex: _selectedIndex,
          // When the user taps on a tab bar item, it calls the `_onItemTapped` handler, which updates the state with the correct `index`.
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card2'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card3'),
          ]),
    );
  }
}
