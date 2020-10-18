import 'package:flutter/material.dart';
import 'package:digital_hack/Models/db.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  // link on data and parcing
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get("https://files.rtuitlab.ru/dbdigital.json");
    var jsn = json.decode(utf8.decode(tstData.bodyBytes));
    List<Deparament> deparaments = [];
    print(jsn["departments"]);
    var jsonData = jsn["departments"];
    for (var dpr in jsonData[0]["company"]) {
      List<Profiles> profiles = [];
      for (var profile in jsonData[0]["company"][dpr["id"]]["profiles"]) {
        List<Tasks> tasks = [];
        if (profile["tasks"] != null)
          for (var tsk in profile["tasks"]) {
            Tasks tsknew = Tasks(tsk["id"], tsk["deadline"], tsk["title"],
                tsk["tags"], tsk["color"], tsk["body"]);
            tasks.add(tsknew);
          }
        Profiles prf = Profiles(profile["id"], profile["name"], profile["img"],
            profile["position"], profile["phone"], profile["email"], tasks);
        profiles.add(prf);
      }
      Deparament deparament =
          Deparament(dpr["id"], dpr["name"], dpr["url"], profiles);
      deparaments.add(deparament);
    }
    print(deparaments);
    return deparaments;
  }

  Widget appBarTitle = new Text(
    "Мои задачи",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();

  List<String> name = [];
  List<String> info = [];
  List<String> date = [];
  List<String> moreinfo = [];
  final List<String> hash = [
    "#Zarp",
    "#Safari",
    "#Tag",
    "#Module",
    "#Hackathon",
    "#Dima",
    "#Digital",
    "#Digital",
    "#Digital",
    "#Digital"
  ];
  bool _isSearching;
  String _searchText = "";
  List<int> indexpage = [];
  HomePage() {
    // Constructor
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  bool alreadyHave = false;
  @override

  // The main widget. Contains a database join. Contains the main interface of the "Tasks" block"
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getJson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Загрузка..."),
              ),
            );
          } else {
            if (!alreadyHave) {
              for (var dep in snapshot.data) {
                for (var profile in dep.profiles) {
                  for (var tsk in profile.tasks) {
                    name.add(tsk.title);
                    info.add(profile.name);
                    moreinfo.add(tsk.body);
                    date.add(tsk.deadline);
                  }
                }
              }
            }
            alreadyHave = true;
            return new Scaffold(
              key: key,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.green,
              ),
              appBar: buildBar(context),
              body: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: new ListView.builder(
                  itemBuilder: _buildFruitItem,
                  itemCount: _buildSearchList(),
                ),
              ),
            );
          }
        });
  }

  // Search string method
  int _buildSearchList() {
    if (_searchText.isEmpty)
      return name.length;
    else
      for (int i = 0; i < name.length; i++)
        if (_searchText == name[i]) return i + 1;
    return 0;
  }

  // Search bar widget
  Widget buildBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  // Method for determining the task color depending on the deadline
  Color deadline(String datea) {
    var d = DateTime.now().day;
    var p = int.parse(datea[0]);
    p *= 10;
    p += int.parse(datea[1]);
    if (p - d < 4) {
      return (Colors.red[100]);
    }
    if (p - d < 7)
      return (Colors.yellow[100]);
    else
      return (Colors.green[100]);
  }

  // Widget for task cases
  Widget _buildFruitItem(BuildContext context, int index) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: deadline(date[index]),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_tree_rounded),
              title: Text(name[index]),
              subtitle: Text(info[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => blu(context, index),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(hash[index])),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text('Выполнить до: ' + date[index],
                        textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Notes widget for tasks (extended information)
  Widget blu(BuildContext context, int index) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deadline(date[index]),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          name[index],
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(children: [
          Container(
            height: 400.0,
            width: double.infinity,
            color: deadline(date[index]),
            padding: new EdgeInsets.only(top: 50.0, left: 10.0),
            margin: new EdgeInsets.only(top: 10.0),
            child: Text(
              moreinfo[index],
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: 100.0,
              color: deadline(date[index]),
              margin: new EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.article_outlined,
                  ),
                  Text('Document.docx', textAlign: TextAlign.center),
                ],
              )),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "Font2",
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "Font2",
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.green,
        onTap: (int id) {
          if (id == 0) {
            name.remove(index);
            info.remove(index);
            date.remove(index);
            moreinfo.remove(index);
            hash.remove(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => (MainPage()),
              ),
            );
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Удалить задачу2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.double_arrow_rounded),
            label: 'Передать задачу',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_done_outlined),
            label: 'Выполнить задачу',
          ),
        ],
      ),
    );
  }

  void _handleSearchStart() {
    // A method for searching
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    // A method for searching
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}

/*class AddTaskTab extends StatefulWidget {
  @override
  _AddTaskTabState createState() => _AddTaskTabState();
}

class _AddTaskTabState extends State<AddTaskTab> {
  @override
  Widget build(BuildContext context) {
    return Scafford(

    );
  }
}*/

/*class AddTaskTab extends StatefulWidget {
  @override
  _AddTaskTabState createState() => _AddTaskTabState();
}

class _AddTaskTabState extends State<AddTaskTab> {
  @override
  Widget build(BuildContext context) {
    return Scafford(

    );
  }
}*/
