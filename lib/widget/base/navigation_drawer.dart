import 'package:bmi/screens/history_screen.dart';
import 'package:bmi/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bmi6.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: _selectedDestination == 1,
            onTap: () {
              selectDestination(1);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            selected: _selectedDestination == 1,
            onTap: () {
              selectDestination(1);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HistoryScreen();
              }));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              'Copyright',
            ),
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
