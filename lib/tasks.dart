import 'package:flutter/material.dart';
import 'package:digital_hack/Models/db.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  Future<List<Deparament>> _getJson() async {
    var tstData = await http.get("https://fakegames.herokuapp.com/");
    // print(tstData);
    var jsn = json.decode(tstData.body);
    // print(jsonData);
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
    "Search Sample",
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
  bool _isSearching;
  String _searchText = "";
  List<int> indexpage = [];
  HomePage() {
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

  /*void add_task(String name, String info, String date,String moreinfo){
    this.name.add(name);
    this.info.add(info);
    this.date.add(date);
    this.moreinfo.add(moreinfo);
  }*/
  @override
  Widget build(BuildContext context) {
    bool alreadyHave = false;
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
            // get dara from json
            if (!alreadyHave) {
              for (var dep in snapshot.data) {
                // print(dep.name);
                for (var profile in dep.profiles) {
                  // print(profile.name);
                  for (var tsk in profile.tasks) {
                    // TODO:
                    name.add(tsk.title);
                    info.add(dep.profiles[0].name);
                    moreinfo.add(tsk.body);
                    date.add(tsk.deadline);
                    // получить цвет
                    //tsk.color
                  }
                }
              }
            }
            alreadyHave = true;
            return new Scaffold(
              key: key,
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

  int _buildSearchList() {
    if (_searchText.isEmpty)
      return name.length;
    else
      for (int i = 0; i < name.length; i++)
        if (_searchText == name[i]) return i + 1;
    return 0;
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
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

  Widget _buildFruitItem(BuildContext context, int index) {
    return Center(
      child: Card(
        color: Colors.green[100],
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Выполнить до: '),
                Text(date[index]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('#хештег'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget blu(BuildContext context, int index) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 400.0,
            height: 400.0,
            color: Colors.yellow[100],
            padding: new EdgeInsets.only(top: 50.0),
            child: Text(
              moreinfo[index],
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.backspace),
      ),
      /*body: Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(moreinfo[index]),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('Назад'),
              ),
            ),
          ],
        ),
      ),*/
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
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
