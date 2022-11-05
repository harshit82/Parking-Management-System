/// This is the home screen of the app
import 'package:flutter/material.dart';
import 'package:vehicle_parking_management/views/history.dart';
import 'package:vehicle_parking_management/views/parking_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    _currentIndex = 0;
    _screens = [
      ParkingData(),
      const HistoryScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.blue,
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                backgroundColor: Colors.amber,
                label: "History",
              ),
            ]),
      ),
    );
  }
}
