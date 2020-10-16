import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_hack/profile.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мое приложение',
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

final Color navIconColor = Colors.white;

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.explore, size: 30, color: navIconColor),
          Icon(Icons.line_weight, size: 30, color: navIconColor),
          Icon(Icons.message, size: 30, color: navIconColor),
          Icon(Icons.history, size: 30, color: navIconColor),
          Icon(Icons.perm_identity, size: 30, color: navIconColor),
        ],
        backgroundColor: Colors.white,
        color: Colors.green,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _controller.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          });
        },
      ),
      body: Container(
        child: PageView(
          controller: _controller, // assign it to PageView
          children: <Widget>[
            Center(
              child: Text('Вкладка 1'),
            ),
            Center(
              child: Text('Вкладка 2'),
            ),
            Center(
              child: Text('Вкладка 3'),
            ),
            Center(
              child: Text('Вкладка 4'),
            ),
            Profile() //пример вкладки
          ],
        ),
      ),
    );
  }
}

final _controller = PageController();
