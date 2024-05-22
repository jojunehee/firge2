import 'package:flutter/material.dart';
import 'pages/refrigerator.dart';
import 'pages/recipe.dart';
import 'pages/mypage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = MaterialColor(0xFF24AA5A, {
      50: Color(0xFF24AA5A),
    });

    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Refrigerator(),
    Recipe(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My App'),
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen),
              label: '냉장고',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: '레시피',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF24AA5A),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
