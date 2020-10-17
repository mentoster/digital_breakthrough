import 'package:digital_hack/history.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_hack/profile.dart';
import 'package:digital_hack/tasks.dart';
import 'package:digital_hack/chat/screens/home_screen.dart';
import 'package:digital_hack/map.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

final Color navIconColor = Colors.white;

var id = 0;

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
            MapVkld(),
            MainPage(),
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chat',
              theme: ThemeData(
                primaryColor: Colors.green,
                accentColor: Color(0xFFFEF9EB),
              ),
              home: HomeScreen(),
            ),
            SearchList(),
            Profile(id, "бухгалтерия") //пример вкладки
          ],
        ),
      ),
    );
  }
}

final _controller = PageController();
